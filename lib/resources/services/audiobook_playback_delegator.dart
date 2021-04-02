import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';
import 'package:librivox_audiobook_player/resources/services/audio_player_service.dart';

enum SkipDirection { BACKWARD, FORWARD }
const SKIP_TIME_MILLIS = 3000; // amount skip buttons go forward or backward

class AudiobookPlaybackDelegator {

  final AudioPlayerService audioPlayerService;

  AudiobookPlaybackDelegator({@required this.audioPlayerService});

  playAudiobook({Audiobook audiobook}) {
      if (audiobook.chapters == null) {
        throw "Chapters not yet retrieved for audiobook. Cannot begin playback";
      }

      // Fetch current chapter and timestamp in chapter
      Chapter currChapter = audiobook.chapters[0]; // TODO: GET ACTUAL CURR CHAPTER FROM STORAGE

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

  setAudiobookPosition(double timestampMillis) {
    audioPlayerService.setCurrentPosition(timestampMillis);
  }

  // Fast forward or rewind by a predefined time interval
  // Returns the new timestamp in millis after the change is made
  double skip(SkipDirection direction, Audiobook audiobook) {
    var currMillis = audioPlayerService.getCurrentPositionMillis();
    var offset = direction == SkipDirection.FORWARD ? SKIP_TIME_MILLIS : -1 * SKIP_TIME_MILLIS;
    var newMillis = currMillis + offset;
    newMillis = max(0, newMillis);
    // newMillis = min(audiobook.durationSeconds, newMillis);

    audioPlayerService.setCurrentPosition(newMillis);
    return newMillis;
  }

}