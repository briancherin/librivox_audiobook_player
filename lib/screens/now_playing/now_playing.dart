

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librivox_audiobook_player/components/cover_image.dart';
import 'package:librivox_audiobook_player/components/play_button.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/screens/now_playing/components/audio_slider.dart';

class NowPlayingScreen extends StatelessWidget {
  final Audiobook audiobook;

  const NowPlayingScreen({@required this.audiobook});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Container(
          child: Center(
            child: Column(
              children: [
                CoverImage(audiobook: audiobook),
                PlayButton(state: PlayButtonState.PLAYING),
                AudioSlider(),
              ]
            ),
          )
        )
      )
    );
  }

}