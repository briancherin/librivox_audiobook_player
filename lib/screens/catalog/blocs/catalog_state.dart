
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

abstract class CatalogState extends Equatable {
  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Audiobook> audiobooks;

  CatalogLoaded({@required this.audiobooks});

  @override
  List<Object> get props => [audiobooks];
}

class AudiobookClicked extends CatalogState {
  final Audiobook audiobook;

  AudiobookClicked({@required this.audiobook});

  @override
  List<Object> get props => [audiobook];
}