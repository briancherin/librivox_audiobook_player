
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/services/audio_player_service.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_state.dart';

class AudiobookInfoBloc extends Bloc<AudiobookInfoEvent, AudiobookInfoState> {

  final AudioPlayerService audioPlayerService;

  AudiobookInfoBloc({@required this.audioPlayerService}):
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
    yield state.copyWith(audiobook: event.audiobook, currentState: AudiobookInfoLoaded(), audiobookIsPlaying: audiobookCurrentlyPlaying);
  }

  Stream<AudiobookInfoState> _mapUserClickedPlayToState(UserClickedPlay event) async* {
    // TODO: GET ACTUAL CORRECT URL TO PLAY FROM (FOR CORRECT CHAPTER IN BOOK)
    String url = "https://archive.org/download/dracula_librivox/dracula_11_stoker.mp3";
    audioPlayerService.play(url);
    yield state.copyWith(audiobookIsPlaying: true);
  }

  Stream<AudiobookInfoState> _mapUserClickedPauseToState(UserClickedPause event) async* {
    audioPlayerService.pause();
    yield state.copyWith(audiobookIsPlaying: false);
  }

}