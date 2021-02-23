
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

abstract class CatalogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CatalogOpened extends CatalogEvent {
  final int maxInitialItems;

  CatalogOpened({@required this.maxInitialItems});

  List<Object> get props => [maxInitialItems];
}

class LoadMoreResults extends CatalogEvent {}
