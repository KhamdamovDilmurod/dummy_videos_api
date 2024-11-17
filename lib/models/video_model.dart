class VideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final String uploadTime;
  final String views;
  final String author;
  final String videoUrl;
  final String description;
  final String subscriber;
  final bool isLive;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.uploadTime,
    required this.views,
    required this.author,
    required this.videoUrl,
    required this.description,
    required this.subscriber,
    required this.isLive,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      thumbnailUrl: json['thumbnailUrl']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      uploadTime: json['uploadTime']?.toString() ?? '',
      views: json['views']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
      videoUrl: json['videoUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      subscriber: json['subscriber']?.toString() ?? '',
      isLive: json['isLive'] == 1 || json['isLive'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'uploadTime': uploadTime,
      'views': views,
      'author': author,
      'videoUrl': videoUrl,
      'description': description,
      'subscriber': subscriber,
      'isLive': isLive ? 1 : 0, // Convert boolean to integer for SQLite
    };
  }
}