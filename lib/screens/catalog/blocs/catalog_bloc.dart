
import 'package:bloc/bloc.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_event.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final AudiobookRepository _audiobookRepository;

  CatalogBloc(AudiobookRepository audiobookRepository) :
      assert(audiobookRepository != null),
      _audiobookRepository = audiobookRepository,
      super(CatalogInitial());

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is CatalogOpened) {
      yield* _mapUserClickedAudiobookToState(event);
    }

    /*if (event is UserClickedAudiobook) {
      yield* _mapAudiobookClickedToState(event);
    }*/
  }

  Stream<CatalogState> _mapUserClickedAudiobookToState(CatalogOpened event) async* {

    yield CatalogLoading();
    // Fetch audiobooks
    //TODO: Get actual data
    List<Audiobook> audiobooks = await _audiobookRepository.fetchAudiobooks();

    yield CatalogLoaded(audiobooks: audiobooks);
  }
/*
  Stream<CatalogState> _mapAudiobookClickedToState(UserClickedAudiobook event) async* {
    yield AudiobookClicked(audiobook: event.audiobook);
  }*/

}