
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

abstract class AudiobookInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AudiobookInfoOpened extends AudiobookInfoEvent {}

class UserClickedPlay extends AudiobookInfoEvent {
  final Audiobook audiobook;

  UserClickedPlay({@required this.audiobook});

  @override
  List<Object> get props => [audiobook];
}