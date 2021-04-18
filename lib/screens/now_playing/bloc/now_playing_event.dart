
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/resources/services/audiobook_playback_delegator.dart';

abstract class NowPlayingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserOpenedNowPlaying extends NowPlayingEvent {
  final Audiobook audiobook; // The audiobook the user opened
  final bool shouldBeginPlayback;

  UserOpenedNowPlaying({@required this.audiobook, this.shouldBeginPlayback = false});

  @override
  List<Object> get props => [audiobook, shouldBeginPlayback];
}

class UserMovedPlaybackSlider extends NowPlayingEvent {
  final double position;

  UserMovedPlaybackSlider({@required this.position});

  @override
  List<Object> get props => [position];
}

class UserReleasedPlaybackSlider extends NowPlayingEvent {
  final double releasePosition;

  UserReleasedPlaybackSlider({@required this.releasePosition});

  @override
  List<Object> get props => [releasePosition];
}

class UserClickedPlaybackSlider extends NowPlayingEvent {}

class NowPlayingUserClickedPlayButton extends NowPlayingEvent {}

class NowPlayingUserClickedPauseButton extends NowPlayingEvent {}

class NowPlayingUserClickedSkipButton extends NowPlayingEvent {
  final SkipDirection direction;

  NowPlayingUserClickedSkipButton({@required this.direction});

  @override
  List<Object> get props => [direction];
}

class NowPlayingAudiobookPositionChanged extends NowPlayingEvent {
  final double newTimestampMillis;

  NowPlayingAudiobookPositionChanged({@required this.newTimestampMillis});

  @override
  List<Object> get props => [newTimestampMillis];
}
