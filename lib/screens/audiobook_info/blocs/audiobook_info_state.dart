
import 'package:equatable/equatable.dart';

class AudiobookInfoState extends Equatable {
  final AudiobookInfoState currentState;
  final bool audiobookIsPlaying;

  AudiobookInfoState({this.currentState, this.audiobookIsPlaying = false});

  AudiobookInfoState copyWith({AudiobookInfoState currentState, bool audiobookIsPlaying}) {
    return AudiobookInfoState(
      currentState: currentState ?? this.currentState,
      audiobookIsPlaying: audiobookIsPlaying ?? this.audiobookIsPlaying
    );
  }


  @override
  List<Object> get props => [currentState, audiobookIsPlaying];
}

class AudiobookInfoInitial extends AudiobookInfoState {}

// class AudiobookPlaying extends AudiobookInfoState {}