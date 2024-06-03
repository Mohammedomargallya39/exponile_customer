import 'package:equatable/equatable.dart';

import '../../domain/entities/main_search_entity.dart';

abstract class HomeState extends Equatable{}

class Empty extends HomeState {
  @override
  List<Object?> get props => [];
}

class Loading extends HomeState {
  @override
  List<Object?> get props => [];
}

class Loaded extends HomeState {
  @override
  List<Object?> get props => [];
}

class InitState extends HomeState{
  @override
  List<Object?> get props => [];
}


class ChangeState extends HomeState{
  @override
  List<Object?> get props => [];
}

class FilterState extends HomeState{
  @override
  List<Object?> get props => [];
}


class HomeChangeNavBottomScreensState extends HomeState{
  @override
  List<Object?> get props => [];
}



class MainSearchProductsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class MainSearchProductsSuccessState extends HomeState {
  final MainSearchProductEntity mainSearchProductEntity;


  MainSearchProductsSuccessState({required this.mainSearchProductEntity});

  @override
  List<Object?> get props => [mainSearchProductEntity];
}

class MainSearchProductsErrorState extends HomeState {
  final String failure;

  MainSearchProductsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}