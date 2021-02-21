
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserClickedLibrary extends NavigationEvent {}

class UserClickedCatalog extends NavigationEvent {}