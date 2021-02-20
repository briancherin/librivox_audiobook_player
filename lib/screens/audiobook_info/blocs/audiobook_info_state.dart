
import 'package:equatable/equatable.dart';

abstract class AudiobookInfoState extends Equatable {
  @override
  List<Object> get props => [];
}

class AudiobookInfoInitial extends AudiobookInfoState {}

class AudiobookPlaying extends AudiobookInfoState {}