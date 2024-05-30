import 'package:exponile_customer/features/auth/register/domain/entities/register_entity.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class InitsState extends RegisterStates{}
class ChangeState extends RegisterStates{}
class AcceptingState extends RegisterStates{}


class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterEntity registerEntity;


  RegisterSuccessState({required this.registerEntity});

  List<Object?> get props => [registerEntity];
}

class RegisterErrorState extends RegisterStates {
  final String failure;
  RegisterErrorState({required this.failure});
}


class CategoriesLoadingState extends RegisterStates {}

class CategoriesSuccessState extends RegisterStates {}

class CategoriesErrorState extends RegisterStates {
  final String failure;
  CategoriesErrorState({required this.failure});
}


class CitiesLoadingState extends RegisterStates {}

class CitiesSuccessState extends RegisterStates {}

class CitiesErrorState extends RegisterStates {
  final String failure;
  CitiesErrorState({required this.failure});
}


class AreasLoadingState extends RegisterStates {}

class AreasSuccessState extends RegisterStates {}

class AreasErrorState extends RegisterStates {
  final String failure;
  AreasErrorState({required this.failure});
}


class FilterState extends RegisterStates {}






