
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';

class LibrivoxAudiobookProvider extends AudiobookProvider {

  @override
  Future<List<Audiobook>> fetchAudiobooks() {
    //TODO: Get actual data
    List<Audiobook> audiobooks = [
      Audiobook(title: "Book 1", numChapters: 5, author: "Billy Bob", duration: 3615),
      Audiobook(title: "Book 2", numChapters: 5, author: "Bob Jones", duration: 27055),
      Audiobook(title: "Book 3", numChapters: 5, author: "Jane Janeson", duration: 11887),
    ];

    return Future.value(audiobooks);
  }

}