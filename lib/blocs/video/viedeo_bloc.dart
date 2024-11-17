import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/movie_repository.dart';
import 'video_event.dart';
import 'video_state.dart';
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository repository;

  VideoBloc({required this.repository}) : super(VideoInitial()) {
    on<LoadVideos>(_onLoadVideos);
    on<RefreshVideos>(_onRefreshVideos);
  }

  Future<void> _onLoadVideos(LoadVideos event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    try {
      final videos = await repository.getVideos();
      emit(VideoLoaded(videos));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<void> _onRefreshVideos(RefreshVideos event, Emitter<VideoState> emit) async {
    try {
      final videos = await repository.getVideos();
      emit(VideoLoaded(videos));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<void> _onClearCache(ClearCache event, Emitter<VideoState> emit) async {
    try {
      if (repository is VideoRepositoryImpl) {
        await (repository as VideoRepositoryImpl).clearCache();
      }
      emit(VideoInitial());
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }
}