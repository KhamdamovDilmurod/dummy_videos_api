
import 'package:dummy_videos_api/models/video_model.dart';
import 'package:equatable/equatable.dart';

abstract class PlayerrState extends Equatable {
  const PlayerrState();

  @override
  List<Object> get props => [];
}

class PlayerInitial extends PlayerrState {}

class PlayerLoading extends PlayerrState {}

class PlayerReady extends PlayerrState {
  final VideoModel video;

  const PlayerReady(this.video);

  @override
  List<Object> get props => [video];
}

class PlayerError extends PlayerrState {
  final String message;

  const PlayerError(this.message);

  @override
  List<Object> get props => [message];
}