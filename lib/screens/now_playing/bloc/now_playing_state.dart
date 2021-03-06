import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

class NowPlayingState extends Equatable {
  final NowPlayingState currentState;
  final Audiobook audiobook;
  final double currentPositionMillis;
  final bool audiobookIsPlaying;
  final bool chaptersLoaded;

  NowPlayingState({@required this.currentState, this.audiobook, this.currentPositionMillis, this.audiobookIsPlaying, this.chaptersLoaded = false});

  NowPlayingState copyWith({NowPlayingState currentState, Audiobook audiobook, double currentPositionMillis, bool audiobookIsPlaying, bool chaptersLoaded}) {
    return NowPlayingState(
      currentState: currentState ?? this.currentState,
      audiobook: audiobook ?? this.audiobook,
      currentPositionMillis: currentPositionMillis ?? this.currentPositionMillis,
      audiobookIsPlaying: audiobookIsPlaying ?? this.audiobookIsPlaying,
      chaptersLoaded: this.chaptersLoaded,
    );
  }

  @override
  List<Object> get props => [currentState, audiobook, currentPositionMillis, audiobookIsPlaying];
}

class NowPlayingInitial extends NowPlayingState {}

class AudiobookUserDataLoaded extends NowPlayingState {}