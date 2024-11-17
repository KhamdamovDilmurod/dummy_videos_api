import 'dart:io';

import 'package:dummy_videos_api/repository/movie_repository.dart';
import 'package:dummy_videos_api/screens/video_list_screen.dart';
import 'package:dummy_videos_api/services/api_services.dart';
import 'package:dummy_videos_api/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'blocs/player/player_bloc.dart';
import 'blocs/video/viedeo_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the database factory to use FFI
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VideoBloc(
            repository: VideoRepositoryImpl(
                apiService: ApiService(),
                localStorage: LocalStorageService(DatabaseService())),
          ),
        ),
        BlocProvider(
          create: (context) => PlayerBloc(
            player: Player(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Video Player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: const VideoListScreen(),
      ),
    );
  }
}
