

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
import 'package:librivox_audiobook_player/util/string_util.dart';

import '../../resources/models/chapter.dart';
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
              Chapter currentChapter = state.audiobook.chapters[state.currentChapterIndex];

              return Container(
                  child: Center(
                    child: Column(
                        children: [
                          CoverImage(audiobook: state.audiobook),
                          SizedBox(height: 10),
                          _getChapterInfoHeader(state.audiobook, currentChapter),
                          SizedBox(height: 10),
                          _getAudioSlider(context, state.audiobook, state.currentPositionMillis, state.currentChapterIndex),
                          _getTimestampIndicator(state.currentPositionMillis, currentChapter.durationSeconds), // Current timestamp and time remaining in chapter
                          SizedBox(height: 20),
                          _getPlayerControls(context, state)
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


  _getChapterInfoHeader(Audiobook audiobook, Chapter currentChapter) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Chapter ${currentChapter.chapterNumber} - ${currentChapter.title}',
          style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
        SizedBox(height:5),
        Text(audiobook.title, textAlign: TextAlign.center),
      ]
    );



  }

  _getPlayerControls(BuildContext context, NowPlayingState state) {
    return Row(
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

  _getAudioSlider(context, Audiobook audiobook, double currPositionMillis, int currChapterIndex) {
    return AudioSlider(
      durationMillis: audiobook.chapters[currChapterIndex].durationSeconds * 1000.0,
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

  // Displays the current timestamp within the chapter, and the amount of time remaining in chapter
  _getTimestampIndicator(double currPositionMillis, double chapterDurationSeconds) {

    double currPositionSeconds = (currPositionMillis ~/ 1000) * 1.0;
    double secondsRemaining = chapterDurationSeconds - currPositionSeconds;

    String currTimestamp = StringUtil.getTimestampFromSeconds(currPositionSeconds);
    String secondsRemainingString = StringUtil.getTimestampFromSeconds(secondsRemaining);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(currTimestamp),
        Text(' / '),
        Text('-' + secondsRemainingString)
      ]
    );
  }

}