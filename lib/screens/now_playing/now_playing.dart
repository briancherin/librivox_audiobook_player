

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/components/cover_image.dart';
import 'package:librivox_audiobook_player/components/generic_icon_button.dart';
import 'package:librivox_audiobook_player/components/play_button.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/services/audiobook_playback_delegator.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_bloc.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_event.dart';
import 'package:librivox_audiobook_player/screens/now_playing/components/audio_slider.dart';

import 'bloc/now_playing_state.dart';


class NowPlayingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
          builder: (context, NowPlayingState state) {
            if (state.currentState is NowPlayingInitial) {
              return CircularProgressIndicator(strokeWidth: 4);
            }
            if (state.currentState is AudiobookUserDataLoaded) {
              return Container(
                  child: Center(
                    child: Column(
                        children: [
                          CoverImage(audiobook: state.audiobook),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _getSkipButton(context, SkipDirection.BACKWARD),
                              SizedBox(width: 10),
                              PlayButton(
                                state: state.audiobookIsPlaying ? PlayButtonState.PLAYING : PlayButtonState.PAUSED,
                                onTap: () {
                                  BlocProvider.of<NowPlayingBloc>(context).add(
                                      state.audiobookIsPlaying
                                          ? NowPlayingUserClickedPauseButton()
                                          : NowPlayingUserClickedPlayButton()
                                  );
                                },
                              ),
                              SizedBox(width: 10),
                              _getSkipButton(context, SkipDirection.FORWARD)
                            ],
                          ),
                          _getAudioSlider(context, state.audiobook, state.currentPositionMillis),
                        ]
                    ),
                  )
              );
            }
            return CircularProgressIndicator(strokeWidth: 4);
          },
        )






      )
    );
  }


  _getSkipButton(context, SkipDirection direction) {
    return GenericIconButton(
      height: 80,
      width: 80,
      icon: Icon(direction == SkipDirection.BACKWARD
          ? Icons.replay_30
          : Icons.forward_30, size: 50
      ), // TODO: Be able to change skip interval in settings
      onTap: () {
        BlocProvider.of<NowPlayingBloc>(context).add(NowPlayingUserClickedSkipButton(direction: direction));
      },
    );
  }

  _getAudioSlider(context, Audiobook audiobook, double currPositionMillis) {
    return AudioSlider(
      durationMillis: audiobook.durationSeconds * 1000.0,
      currPositionMillis: currPositionMillis,
      onChanged: (newPosition) {
        BlocProvider.of<NowPlayingBloc>(context).add(UserMovedPlaybackSlider(position: newPosition));
      },
      onChangeStart: (newPosition) {
        BlocProvider.of<NowPlayingBloc>(context).add(UserClickedPlaybackSlider());
      },
      onChangeEnd: (newPosition) {
        BlocProvider.of<NowPlayingBloc>(context).add(UserReleasedPlaybackSlider(releasePosition: newPosition));
      },
    );
  }

}