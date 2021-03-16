

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/services/audio_player_service.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_event.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final AudioPlayerService audioPlayerService;

  NowPlayingBloc({@required this.audioPlayerService}) :
      super(NowPlayingState(currentState: NowPlayingInitial(), audiobookIsPlaying: true)); // TODO: Should audiobookIsPlaying always be true at start?

  @override
  Stream<NowPlayingState> mapEventToState(NowPlayingEvent event) async* {
    if (event is UserOpenedNowPlaying) {
      yield* _mapUserOpenedNowPlayingToState(event);
    }

    if (event is UserMovedPlaybackSlider) {
      yield* _mapUserMovedPlaybackSliderToState(event);
    }

    if (event is UserClickedPlaybackSlider) {
      yield* _mapUserClickedPlaybackSliderToState(event);
    }

    if (event is UserReleasedPlaybackSlider) {
      yield* _mapUserReleasedPlaybackSliderToState(event);
    }

    if (event is NowPlayingUserClickedPlayButton) {
      yield* _mapUserClickedPlayToState(event);
    }
  }

  Stream<NowPlayingState> _mapUserOpenedNowPlayingToState(UserOpenedNowPlaying event) async* {
    // Set the audiobook for the now playing screen. (When the user clicked to open now playing, this event was
    // triggered with the audiobook passed in here, and now we tell the UI what book it is.)
    // Also retrieve the current position in the audiobook and yield it in the initial state
    double currPosMillis = 0; // TODO: get actual current position in audiobook from storage
    yield state.copyWith(currentState: AudiobookUserDataLoaded(), audiobook: event.audiobook, currentPositionMillis: currPosMillis);
  }

  Stream<NowPlayingState> _mapUserMovedPlaybackSliderToState(UserMovedPlaybackSlider event) async* {
    yield state.copyWith(currentPositionMillis: event.position);
  }

  Stream<NowPlayingState> _mapUserClickedPlaybackSliderToState(UserClickedPlaybackSlider event) async* {
    // TODO: Pause the audio currently being played (if playing)
    print("USER CLICKED PLAYBACK SLIDER. PAUSING ANY AUDIO.");
  }

  Stream<NowPlayingState> _mapUserReleasedPlaybackSliderToState(UserReleasedPlaybackSlider event) async* {
    // TODO: Start playing the audio at this position
    // If currently paused, only set the new position (wait for the user to press play)
    print("USER RELEASED PLAYBACK SLIDER. PLAYING AUDIO AT POSITION: ${event.releasePosition}.");

  }

  Stream<NowPlayingState> _mapUserClickedPlayToState(NowPlayingUserClickedPlayButton event) async* {

    if(state.audiobookIsPlaying) {
      // pause
      audioPlayerService.pause();
    }

    yield state.copyWith(audiobookIsPlaying: !state.audiobookIsPlaying);
  }



}