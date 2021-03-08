import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

class NowPlayingState extends Equatable {
  final NowPlayingState currentState;
  final Audiobook audiobook;
  final double currentPositionMillis;
  final bool audiobookIsPlaying;

  NowPlayingState({@required this.currentState, this.audiobook, this.currentPositionMillis, this.audiobookIsPlaying});

  NowPlayingState copyWith({NowPlayingState currentState, Audiobook audiobook, double currentPositionMillis, bool audiobookIsPlaying}) {
    return NowPlayingState(
      currentState: currentState ?? this.currentState,
      audiobook: audiobook ?? this.audiobook,
      currentPositionMillis: currentPositionMillis ?? this.currentPositionMillis,
      audiobookIsPlaying: audiobookIsPlaying ?? this.audiobookIsPlaying
    );
  }

  @override
  List<Object> get props => [currentState, audiobook, currentPositionMillis, audiobookIsPlaying];
}

class NowPlayingInitial extends NowPlayingState {}

class AudiobookUserDataLoaded extends NowPlayingState {}