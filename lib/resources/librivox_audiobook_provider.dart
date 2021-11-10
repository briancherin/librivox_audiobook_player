
import 'dart:convert';

import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/models/chapter.dart';

import 'models/librivox_audiobook.dart';
import 'package:http/http.dart' as http;

class LibrivoxAudiobookProvider extends AudiobookProvider {

  String baseArchiveUrl = "https://archive.org/advancedsearch.php?q=collection:(librivoxaudio)&fl[]=avg_rating,description,downloads,identifier,item_size,title,creator&sort[]=addeddate+desc&output=json";



  @override
  Future<List<Audiobook>> fetchAudiobooks({int offset, int limit}) async {
    String archiveQueryUrl = getArchiveQueryUrl(offset: offset, limit: limit);
    print("LibrivoxAudiobookProvider. fetchAudiobooks queryUrl: $archiveQueryUrl");

    List<Audiobook> audiobooks = [];

    final response = await http.get(Uri.parse(archiveQueryUrl));
    if (response.statusCode == 200) {
      // Request succeeded
      final audiobookJsonList = jsonDecode(response.body)["response"]["docs"];
      for (final audiobookJson in audiobookJsonList) {
        audiobooks.add(LibrivoxAudiobook.fromJSON(audiobookJson));
      }
    } else {
      // TODO: Show error / do something if request fails
    }

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

  String getArchiveQueryUrl({int offset, int limit}) {
    // Pages are indexed starting at 1.
    // The offset should always be a multiple of limit, since
    // we are always retrieving more audiobooks in increments of $limit.
    int page = offset ~/ limit + 1;

    // The number of rows is the limit value because that is how
    // many results we want to show up on each query. i.e. on a given query,
    // we will only be receiving that many results.
    return baseArchiveUrl + "&rows=$limit&page=$page";
  }

}