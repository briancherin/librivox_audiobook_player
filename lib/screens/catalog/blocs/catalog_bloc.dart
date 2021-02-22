
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
      yield* _mapCatalogOpenedToState(event);
    }
    if (event is LoadMoreResults) {
      yield* _mapLoadMoreResultsToState(event);
    }
  }

  Stream<CatalogState> _mapCatalogOpenedToState(CatalogOpened event) async* {

    yield CatalogLoading();
    List<Audiobook> audiobooks = await _audiobookRepository.fetchAudiobooks(offset: 0, limit: 10);
    yield CatalogLoaded(audiobooks: audiobooks, allAudiobooksLoaded: false); // TODO: should probably consolidate both events into one (i.e. this false might be untrue)
  }

  Stream<CatalogState> _mapLoadMoreResultsToState(LoadMoreResults event) async* {
    if (state is CatalogLoaded) {
      CatalogLoaded currState = state as CatalogLoaded;
      if (!currState.allAudiobooksLoaded) {
        var currAudiobooks = currState.audiobooks;
        List<Audiobook> moreAudiobooks = await _audiobookRepository
            .fetchAudiobooks(offset: currAudiobooks.length, limit: 10);
        yield CatalogLoaded(audiobooks: currAudiobooks + moreAudiobooks,
            allAudiobooksLoaded: moreAudiobooks.length == 0);
      }
    }
  }

  }