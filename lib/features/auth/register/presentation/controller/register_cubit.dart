import 'package:exponile_customer/features/auth/register/domain/entities/register_entity.dart';
import 'package:exponile_customer/features/auth/register/presentation/controller/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/usecase/register_usecase.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  final RegisterUseCase _registerUseCase;
  RegisterCubit({
    required RegisterUseCase registerUseCase,
  }):
        _registerUseCase = registerUseCase,
        super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  RegisterEntity? registerEntity;
  void register({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobile,
    required String whatsMobile,
    required String gender,
    required int terms,
  }) async {
    emit(RegisterLoadingState());

    final result = await _registerUseCase(
        RegisterParams(
          userName: email,
          password: password,
          email: email,
          mobile: mobile,
          passwordConfirmation: passwordConfirmation,
          terms: terms,
          whatsMobile: whatsMobile,
          gender: gender,
        )
    );

    result.fold((failure) {
      emit(RegisterErrorState(
          failure: mapFailureToMessage(failure)
      ));
    }, (data) {
      registerEntity = data;
      emit(RegisterSuccessState(registerEntity: data));
    });
  }

  bool isAccepted = false;
  void acceptTerm(){
    emit(InitsState());
    isAccepted = !isAccepted;
    emit(AcceptingState());
  }

  bool isMale = false;
  bool isFemale = false;
  void selectGander({
   required bool isSelectedMale,
   required bool isSelectedFemale,
}){
    emit(InitsState());
    isMale = isSelectedMale;
    isFemale = isSelectedFemale;
    emit(AcceptingState());
  }


}