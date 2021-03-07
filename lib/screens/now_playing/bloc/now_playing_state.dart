import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

class NowPlayingState extends Equatable {
  final NowPlayingState currentState;
  final Audiobook audiobook;
  final double currentPositionMillis;

  NowPlayingState({@required this.currentState, this.audiobook, this.currentPositionMillis});

  NowPlayingState copyWith({NowPlayingState currentState, Audiobook audiobook, double currentPositionMillis}) {
    return NowPlayingState(
      currentState: currentState ?? this.currentState,
      audiobook: audiobook ?? this.audiobook,
      currentPositionMillis: currentPositionMillis ?? this.currentPositionMillis,
    );
  }

  @override
  List<Object> get props => [currentState, audiobook, currentPositionMillis];
}

class NowPlayingInitial extends NowPlayingState {}

class AudiobookUserDataLoaded extends NowPlayingState {}