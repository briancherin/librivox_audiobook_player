
import 'package:bloc/bloc.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_event.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {

  CatalogBloc() : super(CatalogInitial());

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
    List<Audiobook> audiobooks = [
      Audiobook(title: "title1"),
      Audiobook(title: "title2"),
      Audiobook(title: "title3")
    ];
    yield CatalogLoaded(audiobooks: audiobooks);
  }
/*
  Stream<CatalogState> _mapAudiobookClickedToState(UserClickedAudiobook event) async* {
    yield AudiobookClicked(audiobook: event.audiobook);
  }*/

}