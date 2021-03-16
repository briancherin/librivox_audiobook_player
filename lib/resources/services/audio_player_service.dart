

import 'package:audioplayer/audioplayer.dart';

// https://pub.dev/packages/audioplayer
class AudioPlayerService {
  final AudioPlayer _audioPlugin = AudioPlayer();

  // TODO: Make async in case play takes time to start
  play(String url) {
    _audioPlugin.play(url);
  }

  pause() {
    _audioPlugin.pause();
  }

  stop() {
    _audioPlugin.stop();
  }
}