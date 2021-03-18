
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/demo_audiobook_provider.dart';
import 'librivox_audiobook_provider.dart';
import 'models/models.dart';

/*
 * The repository collects different sources of information. So if we want to have
 * multiple different audiobook providers, we aggregate them here and return them
 * in one call.
 */

enum AudiobookProviderName { DEMO, LIBRIVOX }

class AudiobookRepository {
  final Map<AudiobookProviderName, AudiobookProvider> _audiobookProviders = {
    AudiobookProviderName.LIBRIVOX: LibrivoxAudiobookProvider(),
    AudiobookProviderName.DEMO: DemoAudiobookProvider(),
  };

  Future<List<Audiobook>> fetchAudiobooks({int offset=0, int limit}) async {
    print("AudiobookRepository. FetchAudiobooks offset=$offset, limit=$limit");
    List<Audiobook> list = [];
    for (var provider in _audiobookProviders.values) {
      list.addAll(await provider.fetchAudiobooks(offset: offset, limit: limit));
    }
    return list;
  }

  Future<List<Chapter>> fetchChapters({Audiobook audiobook}) {
    if (audiobook is LibrivoxAudiobook) {
      return _audiobookProviders[AudiobookProviderName.LIBRIVOX].fetchChapters(audiobook: audiobook);
    }
    throw "Audiobook provider not found";
  }

}

abstract class AudiobookProvider {
  Future<List<Audiobook>> fetchAudiobooks({int offset, int limit});
  Future<List<Chapter>> fetchChapters({@required Audiobook audiobook});
}