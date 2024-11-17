import 'package:dummy_videos_api/models/video_model.dart';
import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadVideo extends PlayerEvent {
  final VideoModel video;

  const LoadVideo(this.video);

  @override
  List<Object> get props => [video];
}

class PauseVideo extends PlayerEvent {}

class ResumeVideo extends PlayerEvent {}