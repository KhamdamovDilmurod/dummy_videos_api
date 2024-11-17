import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/video/video_event.dart';
import '../blocs/video/video_state.dart';
import '../blocs/video/viedeo_bloc.dart';
import 'widgets/video_list_item.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoInitial) {
            context.read<VideoBloc>().add(LoadVideos());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VideoError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<VideoBloc>().add(LoadVideos());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is VideoLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<VideoBloc>().add(RefreshVideos());
              },
              child: ListView.builder(
                itemCount: state.videos.length,
                itemBuilder: (context, index) {
                  return VideoListItem(video: state.videos[index]);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}