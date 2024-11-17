import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import '../models/video_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'videos.db');

    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE videos(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        thumbnailUrl TEXT,
        duration TEXT,
        uploadTime TEXT,
        views TEXT,
        author TEXT,
        videoUrl TEXT NOT NULL,
        description TEXT,
        subscriber TEXT,
        isLive INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }
}

class LocalStorageService {
  final DatabaseService _databaseService;

  LocalStorageService(this._databaseService);

  Future<void> cacheVideos(List<VideoModel> videos) async {
    final db = await _databaseService.database;
    final batch = db.batch();

    for (final video in videos) {
      batch.insert(
        'videos',
        video.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<VideoModel>> getCachedVideos() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('videos');

    return List.generate(maps.length, (i) {
      return VideoModel.fromJson(maps[i]);
    });
  }

  Future<void> clearCache() async {
    final db = await _databaseService.database;
    await db.delete('videos');
  }
}