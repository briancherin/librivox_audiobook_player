
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';

class AudiobookInfoState extends Equatable {
  final Audiobook audiobook;
  final AudiobookInfoState currentState;
  final bool audiobookIsPlaying;
  final bool chaptersLoaded;

  AudiobookInfoState({this.audiobook, this.currentState, this.audiobookIsPlaying = false, this.chaptersLoaded = false});

  AudiobookInfoState copyWith({Audiobook audiobook, AudiobookInfoState currentState, bool audiobookIsPlaying, bool chaptersLoaded}) {
    return AudiobookInfoState(
      audiobook: audiobook ?? this.audiobook,
      currentState: currentState ?? this.currentState,
      audiobookIsPlaying: audiobookIsPlaying ?? this.audiobookIsPlaying,
      chaptersLoaded: chaptersLoaded ?? this.chaptersLoaded,
    );
  }


  @override
  List<Object> get props => [audiobook, currentState, audiobookIsPlaying];
}

class AudiobookInfoInitial extends AudiobookInfoState {}

class AudiobookInfoLoaded extends AudiobookInfoState {}