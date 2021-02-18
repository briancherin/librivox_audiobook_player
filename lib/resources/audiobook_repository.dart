
import 'package:librivox_audiobook_player/resources/librivox_audiobook_provider.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

/**
 * The repository collects different sources of information. So if we want to have
 * multiple different audiobook providers, we aggregate them here and return them
 * in one call.
 */


class AudiobookRepository {
  final List<AudiobookProvider> _audiobookProviders = [
    LibrivoxAudiobookProvider()
  ];

  Future<List<Audiobook>> fetchAudiobooks() async {
    List<Audiobook> list = [];
    for (var provider in _audiobookProviders) {
      list.addAll(await provider.fetchAudiobooks());
    }
    return list;
  }

}

abstract class AudiobookProvider {
  Future<List<Audiobook>> fetchAudiobooks();
}