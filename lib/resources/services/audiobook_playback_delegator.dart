import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';
import 'package:librivox_audiobook_player/resources/services/audio_player_service.dart';

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

}