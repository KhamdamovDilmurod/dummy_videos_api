import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/video/video_event.dart';
import '../blocs/video/video_state.dart';
import '../blocs/video/viedeo_bloc.dart';
import 'widgets/video_list_item.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
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
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(screenSize.width),
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.videos.length,
                  itemBuilder: (context, index) {
                    final movie = state.videos[index];
                    return VideoListItem(video: movie);
                  },
                ));
          }

          return const SizedBox();
        },
      ),
    );
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth >= 1200) {
      return 4;
    } else if (screenWidth >= 800) {
      return 3;
    } else if (screenWidth >= 600) {
      return 2;
    } else {
      return 1;
    }
  }
}
