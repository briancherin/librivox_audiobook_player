import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
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
    yield state.copyWith(currentState: AudiobookUserDataLoaded(), audiobook: event.audiobook, currentPositionMillis: currPosMillis);

    if (event.shouldBeginPlayback) {
      add(NowPlayingUserClickedPlayButton());
    }
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
      Audiobook audiobookWithChapters; // Either audiobook already has its chapters retrieved, or they will be retrieved

      // If this is the first time pressing play, load the list of chapters for the audiobook
      if (state.audiobook is LibrivoxAudiobook && !state.chaptersLoaded) {
        // Load chapters and track urls for this audiobook
        List<LibrivoxChapter> chapters = (await audiobookRepository.fetchChapters(audiobook: state.audiobook)).cast<LibrivoxChapter>();

        // Set the chapters in the audiobook object and mark chapters as loaded
        audiobookWithChapters = state.audiobook.withChapters(chapters);
        yield state.copyWith(audiobook: audiobookWithChapters, chaptersLoaded: true);
      } else {
        audiobookWithChapters = state.audiobook;
      }

      // Initialize audiobook position listener so the UI will be updated when the position changes
      playbackDelegator.setOnAudiobookPositionChanged((newTimestampMillis) => add(NowPlayingAudiobookPositionChanged(newTimestampMillis: newTimestampMillis)));
      // Start playback
      playbackDelegator.playAudiobook(audiobook: audiobookWithChapters);

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
    yield state.copyWith(currentPositionMillis: event.newTimestampMillis);
  }

}