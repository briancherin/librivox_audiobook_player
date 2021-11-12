
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/models/librivox_audiobook.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';
import 'package:librivox_audiobook_player/resources/services/audiobook_playback_delegator.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_state.dart';

class AudiobookInfoBloc extends Bloc<AudiobookInfoEvent, AudiobookInfoState> {

  final AudiobookPlaybackDelegator playbackDelegator;
  final AudiobookRepository audiobookRepository;

  AudiobookInfoBloc({@required this.playbackDelegator, @required this.audiobookRepository}):
    super(AudiobookInfoState(currentState: AudiobookInfoInitial()));

  @override
  Stream<AudiobookInfoState> mapEventToState(AudiobookInfoEvent event) async* {
    if (event is AudiobookInfoOpened) {
      yield* _mapAudiobookInfoOpenedToState(event);
    }
    if (event is UserClickedPlay) {
      yield* _mapUserClickedPlayToState(event);
    }
    if (event is UserClickedPause) {
      yield* _mapUserClickedPauseToState(event);
    }
  }

  Stream<AudiobookInfoState> _mapAudiobookInfoOpenedToState(AudiobookInfoOpened event) async* {
    // TODO: Check if the opened audiobook is currently playing.
    bool audiobookCurrentlyPlaying = false;

    Audiobook audiobook = event.audiobook;

    // Now that the user selected this book to open, we want to retrieve info about
    // the chapters of the book (i.e. number of chapters)
    List<Chapter> chapters = await audiobookRepository.fetchChapters(audiobook: audiobook);
    audiobook = audiobook.withChapters(chapters);

    yield state.copyWith(audiobook: audiobook, currentState: AudiobookInfoLoaded(), audiobookIsPlaying: audiobookCurrentlyPlaying);
  }

  Stream<AudiobookInfoState> _mapUserClickedPlayToState(UserClickedPlay event) async* {
    // TODO: need to do anything here? (e.g. resume playback) (currently, pressing the play button just launches the now playing screen)

    yield state.copyWith(audiobookIsPlaying: true);

  }

  Stream<AudiobookInfoState> _mapUserClickedPauseToState(UserClickedPause event) async* {
    playbackDelegator.pauseAudiobook();
    yield state.copyWith(audiobookIsPlaying: false);
  }

}