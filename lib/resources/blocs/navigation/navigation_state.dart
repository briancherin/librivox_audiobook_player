
import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowLibrary extends NavigationState {}
class ShowCatalog extends NavigationState {}