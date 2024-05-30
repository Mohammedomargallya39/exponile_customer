import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/usecase/forget_password_usecase.dart';
import '../../domain/usecase/otp_usecase.dart';
import '../../domain/usecase/reset_password_usecase.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final OTPUseCase _otpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit({
    required ForgetPasswordUseCase forgetPasswordUseCase,
    required OTPUseCase otpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })
      :
        _forgetPasswordUseCase = forgetPasswordUseCase,
        _otpUseCase = otpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(ForgetPasswordInitialState());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  bool isSentCode = false;
  bool isFilledCode = false;
  void forgetPassword({
    required String email,
  }) async {
    emit(ForgetPasswordLoadingState());

    final result = await _forgetPasswordUseCase(
        ForgetPasswordParams(
            email: email,
        )
    );

    result.fold((failure) {
      emit(ForgetPasswordErrorState(
          failure: mapFailureToMessage(failure)
      ));
    }, (data) {
      if(data.success ==1){
        isSentCode = true;
      }
      emit(ForgetPasswordSuccessState(
          forgetPasswordEntity: data
      ));
    });
  }


  void verifyOTP({
    required String email,
    required String otp,
  }) async {
    emit(OTPLoadingState());

    final result = await _otpUseCase(
        OTPParams(
          email: email,
          otp: otp
        )
    );

    result.fold((failure) {
      emit(OTPErrorState(
          failure: mapFailureToMessage(failure)
      ));
    }, (data) {
      if(data.success ==1){
        isSentCode = true;
        isFilledCode = true;
      }
      emit(OTPSuccessState(
          otpEntity: data
      ));
    });
  }


  void resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoadingState());

    final result = await _resetPasswordUseCase(
        ResetPasswordParams(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        )
    );

    result.fold((failure) {
      emit(ResetPasswordErrorState(
          failure: mapFailureToMessage(failure)
      ));
    }, (data) {
      isSentCode = false;
      isFilledCode = false;
      emit(ResetPasswordSuccessState(
          resetPasswordEntity: data
      ));
    });
  }




}
