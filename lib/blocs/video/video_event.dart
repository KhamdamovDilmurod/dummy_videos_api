import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideos extends VideoEvent {}

class RefreshVideos extends VideoEvent {}

class ClearCache extends VideoEvent {}