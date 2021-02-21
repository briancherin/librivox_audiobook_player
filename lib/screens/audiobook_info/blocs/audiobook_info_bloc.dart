
import 'package:bloc/bloc.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_state.dart';

class AudiobookInfoBloc extends Bloc<AudiobookInfoEvent, AudiobookInfoState> {

  AudiobookInfoBloc():
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
    yield state.copyWith(audiobookIsPlaying: audiobookCurrentlyPlaying);
  }

  Stream<AudiobookInfoState> _mapUserClickedPlayToState(UserClickedPlay event) async* {
    yield state.copyWith(audiobookIsPlaying: true);
  }

  Stream<AudiobookInfoState> _mapUserClickedPauseToState(UserClickedPause event) async* {
    yield state.copyWith(audiobookIsPlaying: false);
  }

}