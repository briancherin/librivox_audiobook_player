
import 'package:bloc/bloc.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_state.dart';

class AudiobookInfoBloc extends Bloc<AudiobookInfoEvent, AudiobookInfoState> {

  AudiobookInfoBloc():
    super(AudiobookInfoInitial());

  @override
  Stream<AudiobookInfoState> mapEventToState(AudiobookInfoEvent event) async* {
    if (event is UserClickedPlay) {
      yield* _mapUserClickedPlayToState(event);
    }
  }

  Stream<AudiobookInfoState> _mapUserClickedPlayToState(UserClickedPlay event) async* {
    yield AudiobookPlaying();
  }

}