import 'dart:convert';

import 'package:dio/dio.dart';


import 'package:dummy_videos_api/models/video_model.dart';class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json';

  Future<List<VideoModel>> fetchVideos() async {
    try {
      final response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        // Convert the response string to JSON
        if (response.data is String) {
          final List<dynamic> jsonData = List<dynamic>.from(
              List<dynamic>.from(json.decode(response.data))
          );
          return jsonData.map((json) => VideoModel.fromJson(json)).toList();
        } else {
          final List<dynamic> jsonData = List<dynamic>.from(response.data);
          return jsonData.map((json) => VideoModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Failed to load videos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching videos: $e');
    }
  }
}