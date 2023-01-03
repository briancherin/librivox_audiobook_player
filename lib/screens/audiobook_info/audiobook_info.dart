
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/components/cover_image.dart';
import 'package:librivox_audiobook_player/components/play_button.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/services/audio_player_service.dart';
import 'package:librivox_audiobook_player/resources/services/audiobook_playback_delegator.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_bloc.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_bloc.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_event.dart';
import 'package:librivox_audiobook_player/screens/now_playing/now_playing.dart';
import 'package:librivox_audiobook_player/util/string_util.dart';

import 'blocs/audiobook_info_state.dart';

class AudiobookInfoScreen extends StatelessWidget {

  const AudiobookInfoScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocBuilder<AudiobookInfoBloc, AudiobookInfoState>(
          builder: (context, state) {
            Audiobook audiobook = state.audiobook;
            if (state.currentState is AudiobookInfoLoaded) {
              return SingleChildScrollView(
                  child: Center(
                      child: Column(
                        children: [
                          CoverImage(audiobook: audiobook),
                          SizedBox(height: 30),
                          Text(
                            audiobook.title, style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
                          Text("by " + audiobook.author,
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 10),
                          Text(audiobook.numChapters.toString() + " chapters"),
                          Text("Duration: " + StringUtil.getTimestampFromSeconds(
                              audiobook.durationSeconds)),
                          SizedBox(height: 20),
                          PlayButton(
                              state: state.audiobookIsPlaying ? PlayButtonState
                                  .PLAYING : PlayButtonState.PAUSED,
                              onTap: () {
                                BlocProvider.of<AudiobookInfoBloc>(context).add(
                                    state.audiobookIsPlaying
                                        ? UserClickedPause(audiobook: audiobook)
                                        : UserClickedPlay(audiobook: audiobook)
                                );
                                _openNowPlayingScreen(context, audiobook);
                              }
                          ),
                          SizedBox(height: 25),
                          Container(
                            width: 400,
                            child: Center(
                              child: Text(audiobook.description,
                                textAlign: TextAlign.center,),
                            ),
                          ),
                        ],
                      )
                  )
              );
            }
            return CircularProgressIndicator();
          }
        )
      ),
    );
  }

  void _openNowPlayingScreen(context, Audiobook audiobook) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return BlocProvider<NowPlayingBloc>(
          create: (context) {
            AudiobookPlaybackDelegator playbackDelegator = RepositoryProvider.of<AudiobookPlaybackDelegator>(context);
            AudiobookRepository audiobookRepository = RepositoryProvider.of<AudiobookRepository>(context);
            return NowPlayingBloc(playbackDelegator: playbackDelegator, audiobookRepository: audiobookRepository)
              ..add(UserOpenedNowPlaying(audiobook: audiobook, shouldBeginPlayback: true));
          },
          child: NowPlayingScreen(),
        );
      })
    );
  }
}