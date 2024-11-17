import 'package:dummy_videos_api/blocs/player/player_event.dart';
import 'package:dummy_videos_api/blocs/player/player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerrState> {
  final Player player;

  PlayerBloc({required this.player}) : super(PlayerInitial()) {
    on<LoadVideo>(_onLoadVideo);
    on<PauseVideo>(_onPauseVideo);
    on<ResumeVideo>(_onResumeVideo);
  }

  Future<void> _onLoadVideo(LoadVideo event, Emitter<PlayerrState> emit) async {
    emit(PlayerLoading());
    try {
      await player.open(Media(event.video.videoUrl));
      emit(PlayerReady(event.video));
    } catch (e) {
      emit(PlayerError(e.toString()));
    }
  }

  Future<void> _onPauseVideo(PauseVideo event, Emitter<PlayerrState> emit) async {
    await player.pause();
  }

  Future<void> _onResumeVideo(ResumeVideo event, Emitter<PlayerrState> emit) async {
    await player.play();
  }

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}