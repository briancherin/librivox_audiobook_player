import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/resources/models/librivox_audiobook.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';
import 'package:librivox_audiobook_player/resources/services/audio_player_service.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_bloc.dart';
import 'package:librivox_audiobook_player/screens/now_playing/bloc/now_playing_event.dart';

enum SkipDirection { BACKWARD, FORWARD }
const SKIP_TIME_MILLIS = 30000; // amount skip buttons go forward or backward

class AudiobookPlaybackDelegator {

  final AudioPlayerService audioPlayerService;

  AudiobookPlaybackDelegator({@required this.audioPlayerService});

  playAudiobook({Audiobook audiobook}) {
      if (audiobook.chapters == null) {
        throw "Chapters not yet retrieved for audiobook. Cannot begin playback";
      }

      // Fetch current chapter and timestamp in chapter
      Chapter currChapter = audiobook.chapters[0]; // TODO: GET ACTUAL CURR CHAPTER INDEX FROM STORAGE

      // TODO: Also get current timestamp

      // Send chapter url to audio player service
      if (audiobook is LibrivoxAudiobook) {
        audioPlayerService.play((currChapter as LibrivoxChapter).trackUrl);
      }
  }

  pauseAudiobook() {
    // tell audio player service to pause
    audioPlayerService.pause();
  }

  setAudiobookPosition(int timestampMillis) async {
    print("Setting curr position: $timestampMillis");
    await audioPlayerService.setCurrentPosition(timestampMillis);
  }

  // Fast forward or rewind by a predefined time interval
  // Returns the new timestamp in millis after the change is made
  Future<void> skip(SkipDirection direction, Audiobook audiobook) async {
    var currMillis = audioPlayerService.getCurrentPositionMillis();
    var offset = direction == SkipDirection.FORWARD ? SKIP_TIME_MILLIS : -1 * SKIP_TIME_MILLIS;
    int newMillis = currMillis + offset;
    newMillis = max(0, newMillis);
    newMillis = min((audiobook.durationSeconds * 1000).toInt(), newMillis);

    print("Received skip request for $direction $SKIP_TIME_MILLIS millis. Curr timestamp: $currMillis, new timestamp: $newMillis");

    await setAudiobookPosition(newMillis);
  }

  // This initializes a listener of the audio service's current timestamp,
  // and sends an event to Bloc when the audio position changes
  setOnAudiobookPositionChanged(Function(double val) callback) {
    audioPlayerService.setAudioPositionChangedListener((double newPositionMillis) {
      callback(newPositionMillis);
    });
  }

}