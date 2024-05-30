import 'package:equatable/equatable.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/entities/otp_entity.dart';
import '../../domain/entities/reset_password_entity.dart';

abstract class ForgetPasswordStates extends Equatable {}

class ForgetPasswordInitialState extends ForgetPasswordStates {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordLoadingState extends ForgetPasswordStates {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final ForgetPasswordEntity forgetPasswordEntity;


  ForgetPasswordSuccessState({required this.forgetPasswordEntity});

  @override
  List<Object?> get props => [forgetPasswordEntity];
}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  final String failure;

  ForgetPasswordErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class OTPLoadingState extends ForgetPasswordStates {
  @override
  List<Object?> get props => [];
}

class OTPSuccessState extends ForgetPasswordStates {
  final OTPEntity otpEntity;


  OTPSuccessState({required this.otpEntity});

  @override
  List<Object?> get props => [otpEntity];
}

class OTPErrorState extends ForgetPasswordStates {
  final String failure;

  OTPErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class ResetPasswordLoadingState extends ForgetPasswordStates {
  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccessState extends ForgetPasswordStates {
  final ResetPasswordEntity resetPasswordEntity;


  ResetPasswordSuccessState({required this.resetPasswordEntity});

  @override
  List<Object?> get props => [resetPasswordEntity];
}

class ResetPasswordErrorState extends ForgetPasswordStates {
  final String failure;

  ResetPasswordErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
