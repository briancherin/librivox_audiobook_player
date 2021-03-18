
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';

class AudiobookInfoState extends Equatable {
  final Audiobook audiobook;
  final AudiobookInfoState currentState;
  final bool audiobookIsPlaying;

  AudiobookInfoState({this.audiobook, this.currentState, this.audiobookIsPlaying = false});

  AudiobookInfoState copyWith({Audiobook audiobook, AudiobookInfoState currentState, bool audiobookIsPlaying}) {
    return AudiobookInfoState(
      audiobook: audiobook ?? this.audiobook,
      currentState: currentState ?? this.currentState,
      audiobookIsPlaying: audiobookIsPlaying ?? this.audiobookIsPlaying
    );
  }


  @override
  List<Object> get props => [audiobook, currentState, audiobookIsPlaying];
}

class AudiobookInfoInitial extends AudiobookInfoState {}

class AudiobookInfoLoaded extends AudiobookInfoState {}

// class AudiobookPlaying extends AudiobookInfoState {}