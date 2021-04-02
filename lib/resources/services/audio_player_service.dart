

import 'package:audioplayer/audioplayer.dart';

// https://pub.dev/packages/audioplayer
class AudioPlayerService {
  final AudioPlayer _audioPlugin = AudioPlayer();

  AudioPlayerService() {
    /*_audioPlugin.onAudioPositionChanged.listen((Duration event) {
      event.
    });*/
  }

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

  setCurrentPosition(double newPositionMillis) {
    _audioPlugin.seek(newPositionMillis * 1000);
  }

  // TODO: GET ACTUAL VALUE
  double getCurrentPositionMillis() {
    return 0;
    //return _audioPlugin.state
  }
}