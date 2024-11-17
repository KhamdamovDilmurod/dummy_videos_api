// Abstract repository interface
import '../models/video_model.dart';
import '../services/api_services.dart';
import '../services/db_services.dart';

abstract class VideoRepository {
  Future<List<VideoModel>> getVideos();
}

// Concrete implementation of VideoRepository
class VideoRepositoryImpl implements VideoRepository {
  final ApiService apiService;
  final LocalStorageService localStorage;

  VideoRepositoryImpl({
      required this.apiService,
    required this.localStorage});


  @override
  Future<List<VideoModel>> getVideos({bool forceRefresh = false}) async {
    try {

      final videos = await apiService.fetchVideos();
      await localStorage.cacheVideos(videos);
      return videos;
    } catch (e) {
      final cachedVideos = await localStorage.getCachedVideos();
      if (cachedVideos.isNotEmpty) {
        return cachedVideos;
      }
      throw RepositoryException('Failed to fetch videos: $e');
    }
  }

  Future<void> clearCache() async {
    await localStorage.clearCache();
  }
}

// Custom exception for repository operations
class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);

  @override
  String toString() => message;
}