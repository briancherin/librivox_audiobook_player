
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/models/chapter.dart';

class LibrivoxAudiobookProvider extends AudiobookProvider {

  String archiveUrl = "https://archive.org/advancedsearch.php?q=collection:(librivoxaudio)&fl[]=avg_rating,description,downloads,identifier,item_size,title&sort[]=addeddate+desc&rows=10&page=1&output=json";

  String baseImageUrl = "https://archive.org/services/get-item-image.php?identifier=";

  String getImageUrl (String identifier) => baseImageUrl + identifier;

  @override
  Future<List<Audiobook>> fetchAudiobooks({int offset, int limit}) {
    //TODO: Get actual data
    List<Audiobook> audiobooks = [
      LibrivoxAudiobook(librivoxItemId: "dracula_librivox", coverImageUrl: getImageUrl("dracula_librivox"), title: "Book 1", numChapters: 5, author: "Billy Bob", durationSeconds: 3615),
      LibrivoxAudiobook(librivoxItemId: "secret_garden_librivox", coverImageUrl: getImageUrl("secret_garden_librivox"), title: "Book 2", numChapters: 5, author: "Bob Jones", durationSeconds: 27055),
      LibrivoxAudiobook(librivoxItemId: "odyssey_butler_librivox", coverImageUrl: getImageUrl("odyssey_butler_librivox"), title: "Book 3", numChapters: 5, author: "Jane Janeson", durationSeconds: 11887),
    ];

    return Future.value(audiobooks);
  }

  @override
  Future<List<Chapter>> fetchChapters({Audiobook audiobook}) {
    // TODO: Get actual data
    List<Chapter> list = [
      LibrivoxChapter(title: "Chapter 1", trackUrl: "https://archive.org/download/dracula_librivox/dracula_01_stoker.mp3"),
      LibrivoxChapter(title: "Chapter 2", trackUrl: "https://archive.org/download/dracula_librivox/dracula_02_stoker.mp3"),
      LibrivoxChapter(title: "Chapter 3", trackUrl: "https://archive.org/download/dracula_librivox/dracula_03_stoker.mp3"),
    ];
    return Future.value(list);
  }



}