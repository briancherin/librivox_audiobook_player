
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';

import 'package:lipsum/lipsum.dart' as lipsum;

class DemoAudiobookProvider extends AudiobookProvider {


  String baseImageUrl = "https://archive.org/services/get-item-image.php?identifier=";

  String getImageUrl (String identifier) => baseImageUrl + identifier;



  @override
  Future<List<Audiobook>> fetchAudiobooks({int offset, int limit}) async {
    List<Audiobook> data = _data(30);
    List<Audiobook> audiobooksToReturn = [];
    if (limit == null) limit = data.length;
    if (offset <= data.length) {
     if (offset + limit > data.length) {
      audiobooksToReturn = data.sublist(offset, data.length);
     } else {
      audiobooksToReturn = data.sublist(offset, offset + limit);
     }
    }
    await Future.delayed(Duration(milliseconds: 0,));
    return Future.value(audiobooksToReturn);
  }

  List<Audiobook> _data(int size) {
    var getDesc = () {return lipsum.createParagraph(numSentences: 10);};
    List<Audiobook> d = [
    LibrivoxAudiobook(librivoxItemId: "dracula_librivox", coverImageUrl: getImageUrl("dracula_librivox"), title: "Book 1", numChapters: 5, author: "Billy Bob", durationSeconds: 3615, description: getDesc()),
    LibrivoxAudiobook(librivoxItemId: "secret_garden_librivox", coverImageUrl: getImageUrl("secret_garden_librivox"), title: "Book 2", numChapters: 5, author: "Bob Jones", durationSeconds: 27055, description: getDesc()),
    LibrivoxAudiobook(librivoxItemId: "odyssey_butler_librivox", coverImageUrl: getImageUrl("odyssey_butler_librivox"), title: "Book 3", numChapters: 5, author: "Jane Janeson", durationSeconds: 11887, description: getDesc()),
    ];
    return List<Audiobook>.generate(size, (i) => d[i % d.length]);
 }

}