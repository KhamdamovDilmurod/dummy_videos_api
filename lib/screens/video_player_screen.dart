import 'package:dummy_videos_api/models/video_model.dart';
import 'package:dummy_videos_api/screens/widgets/video_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../blocs/player/player_bloc.dart';
import '../blocs/player/player_event.dart';
import '../blocs/player/player_state.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoController(context.read<PlayerBloc>().player);
    context.read<PlayerBloc>().add(LoadVideo(widget.video));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BlocBuilder<PlayerBloc, PlayerrState>(
              builder: (context, state) {
                if (state is PlayerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PlayerError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                }

                return Stack(
                  children: [
                    Video(controller: controller),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoControls(bloc: context.read<PlayerBloc>()),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.video.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}