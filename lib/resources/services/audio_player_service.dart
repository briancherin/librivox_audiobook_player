

import 'package:audioplayer/audioplayer.dart';

// https://pub.dev/packages/audioplayer
class AudioPlayerService {
  final AudioPlayer _audioPlugin = AudioPlayer();

  int _currentPositionMillis = 0;

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

  setCurrentPosition(int newPositionMillis) async {
    double seconds = (newPositionMillis ~/ 1000) as double;
    await _audioPlugin.seek(seconds);
  }


  // TODO: GET ACTUAL VALUE
  int getCurrentPositionMillis() {
    return _currentPositionMillis;
  }

  void setAudioPositionChangedListener(Function(double val) callback) {
    _audioPlugin.onAudioPositionChanged.listen((Duration event) {
      callback(event.inMilliseconds as double);
      _currentPositionMillis = event.inMilliseconds;
      // print("${event.inMilliseconds as double}");
      // _currentPositionMillis = 500;
    });
  }
}