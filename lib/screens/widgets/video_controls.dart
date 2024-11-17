import 'package:flutter/material.dart';

import '../../blocs/player/player_bloc.dart';
import '../../blocs/player/player_event.dart';

class VideoControls extends StatelessWidget {
  final PlayerBloc bloc;

  const VideoControls({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            color: Colors.white,
            onPressed: () => bloc.add(ResumeVideo()),
          ),
          IconButton(
            icon: const Icon(Icons.pause),
            color: Colors.white,
            onPressed: () => bloc.add(PauseVideo()),
          ),
        ],
      ),
    );
  }
}