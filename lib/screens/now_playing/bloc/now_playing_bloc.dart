import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/models/librivox_audiobook.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';
import 'package:librivox_audiobook_player/resources/services/audiobook_playback_delegator.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_event.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_state.dart';


class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final AudiobookPlaybackDelegator playbackDelegator;
  final AudiobookRepository audiobookRepository;

  NowPlayingBloc({@required this.playbackDelegator, @required this.audiobookRepository}) :
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

    if (event is NowPlayingUserClickedPauseButton) {
      yield* _mapUserClickedPauseToState(event);
    }

    if (event is NowPlayingUserClickedSkipButton) {
      yield* _mapUserClickedSkipButtonToState(event);
    }

    if (event is NowPlayingAudiobookPositionChanged) {
      yield* _mapAudiobookPositionChangedToState(event);
    }

  }

  Stream<NowPlayingState> _mapUserOpenedNowPlayingToState(UserOpenedNowPlaying event) async* {
    // Set the audiobook for the now playing screen. (When the user clicked to open now playing, this event was
    // triggered with the audiobook passed in here, and now we tell the UI what book it is.)
    // Also retrieve the current position in the audiobook and yield it in the initial state
    double currPosMillis = 0; // TODO: get actual current position in audiobook from storage
    int currChapter = 0; // TODO: get actual current chapter in audiobook from storage

    yield state.copyWith(currentState: AudiobookUserDataLoaded(),
        audiobook: event.audiobook, currentPositionMillis: currPosMillis, currentChapter: currChapter);

    if (event.shouldBeginPlayback) {
      add(NowPlayingUserClickedPlayButton());
    }
  }

  Stream<NowPlayingState> _mapUserMovedPlaybackSliderToState(UserMovedPlaybackSlider event) async* {
    yield state.copyWith(currentPositionMillis: event.position);
  }

  Stream<NowPlayingState> _mapUserClickedPlaybackSliderToState(UserClickedPlaybackSlider event) async* {
    // If currently playing, ensure that only the new slider position
    // and not the actual playback timestamp is shown on the slider
    yield state.copyWith(userIsMovingAudioSlider: true);
  }

  Stream<NowPlayingState> _mapUserReleasedPlaybackSliderToState(UserReleasedPlaybackSlider event) async* {
    yield state.copyWith(userIsMovingAudioSlider: false);

    await playbackDelegator.setAudiobookPosition(event.releasePosition.toInt());
  }

  Stream<NowPlayingState> _mapUserClickedPlayToState(NowPlayingUserClickedPlayButton event) async* {
      Audiobook audiobook = state.audiobook;

      // Initialize audiobook position listener so the UI will be updated when the position changes
      playbackDelegator.setOnAudiobookPositionChanged((newTimestampMillis) => add(NowPlayingAudiobookPositionChanged(newTimestampMillis: newTimestampMillis)));
      // Start playback
      playbackDelegator.playAudiobook(audiobook: audiobook);

      yield state.copyWith(audiobookIsPlaying: true);
  }

  Stream<NowPlayingState> _mapUserClickedPauseToState(NowPlayingUserClickedPauseButton event) async* {
    playbackDelegator.pauseAudiobook();
    yield state.copyWith(audiobookIsPlaying: false);
  }

  Stream<NowPlayingState> _mapUserClickedSkipButtonToState(NowPlayingUserClickedSkipButton event) async* {
    await playbackDelegator.skip(event.direction, state.audiobook);
    // print("new timestamp: " + newTimestampMillis.toString());
    // yield state.copyWith(currentPositionMillis: newTimestampMillis);
  }

  Stream<NowPlayingState> _mapAudiobookPositionChangedToState(NowPlayingAudiobookPositionChanged event) async* {

    bool audiobookIsPlaying = state.audiobookIsPlaying;
    int currChapterIndex = state.currentChapterIndex;

    // If the user is currently moving the audio slider, prevent the slider
    // position from being changed by the actual playback so that only their
    // movement sets the slider position
    if (state.userIsMovingAudioSlider) {
      yield state;
    } else {
      // Check if we have reached the end of the current chapter
      double newTimestampSeconds = event.newTimestampMillis / 1000;
      double currentChapterLength = state.audiobook.chapters[currChapterIndex].durationSeconds;
      if (newTimestampSeconds >= currentChapterLength) {
        // We have reached the end of the current chapter.

        // Check if this was the last chapter
        if (currChapterIndex == state.audiobook.chapters.length) {
          // Stop playback
          playbackDelegator.stopAudiobook();
          audiobookIsPlaying = false;
        } else {
          // Move to the next chapter
          currChapterIndex++;

          //TODO: TRIGGER PLAYBACK OF NEW CHAPTER
        }
      }

      yield state.copyWith(currentPositionMillis: event.newTimestampMillis, audiobookIsPlaying: audiobookIsPlaying, currentChapter: currChapterIndex);
    }
  }

}