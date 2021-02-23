
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

class CatalogState extends Equatable {
  bool initialItemsLoaded;
  bool allItemsLoaded;
  List<Audiobook> audiobooks;
  CatalogState currState;

  CatalogState({this.initialItemsLoaded = false, this.allItemsLoaded = false, this.audiobooks, this.currState});

  @override
  List<Object> get props => [initialItemsLoaded, allItemsLoaded, audiobooks, currState];

  CatalogState copyWith({bool initialItemsLoaded, bool allItemsLoaded, List<Audiobook> audiobooks, CatalogState currState}) {
    return CatalogState(
      initialItemsLoaded: initialItemsLoaded ?? this.initialItemsLoaded,
      allItemsLoaded: allItemsLoaded ?? this.allItemsLoaded,
      audiobooks: audiobooks ?? this.audiobooks,
      currState: currState ?? this.currState,
    );
  }
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {}

class AudiobookClicked extends CatalogState {
  final Audiobook audiobook;

  AudiobookClicked({@required this.audiobook});

  @override
  List<Object> get props => [audiobook];
}