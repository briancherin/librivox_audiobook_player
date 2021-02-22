
import 'package:librivox_audiobook_player/resources/demo_audiobook_provider.dart';
import 'package:librivox_audiobook_player/resources/librivox_audiobook_provider.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

/*
 * The repository collects different sources of information. So if we want to have
 * multiple different audiobook providers, we aggregate them here and return them
 * in one call.
 */


class AudiobookRepository {
  final List<AudiobookProvider> _audiobookProviders = [
    // LibrivoxAudiobookProvider(),
    DemoAudiobookProvider(),
  ];

  Future<List<Audiobook>> fetchAudiobooks({int offset=0, int limit}) async {
    print("AudiobookRepository. FetchAudiobooks offset=$offset, limit=$limit");
    List<Audiobook> list = [];
    for (var provider in _audiobookProviders) {
      list.addAll(await provider.fetchAudiobooks(offset: offset, limit: limit));
    }
    return list;
  }

}

abstract class AudiobookProvider {
  Future<List<Audiobook>> fetchAudiobooks({int offset, int limit});
}