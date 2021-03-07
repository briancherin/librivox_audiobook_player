
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

abstract class NowPlayingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserOpenedNowPlaying extends NowPlayingEvent {
  final Audiobook audiobook; // The audiobook the user opened

  UserOpenedNowPlaying({@required this.audiobook});

  @override
  List<Object> get props => [audiobook];
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