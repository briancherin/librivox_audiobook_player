
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';

class LibrivoxAudiobookProvider extends AudiobookProvider {

  @override
  Future<List<Audiobook>> fetchAudiobooks() {
    //TODO: Get actual data
    List<Audiobook> audiobooks = [
      Audiobook(title: "title111"),
      Audiobook(title: "title2"),
      Audiobook(title: "title3")
    ];

    return Future.value(audiobooks);
  }

}