import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class OnboardingCompleted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String nationalId;
  final String phoneNumber;

  const LoginRequested({required this.nationalId, required this.phoneNumber});

  @override
  List<Object> get props => [nationalId, phoneNumber];
}

class OtpSubmitted extends AuthEvent {
  final String otp;

  const OtpSubmitted(this.otp);

  @override
  List<Object> get props => [otp];
}

class AppPasswordSet extends AuthEvent {
  final String password;

  const AppPasswordSet(this.password);

  @override
  List<Object> get props => [password];
}

class VerificationAcknowledged extends AuthEvent {}

class FaceIdSetupRequested extends AuthEvent {}

class FaceIdSetupSkipped extends AuthEvent {}

class FaceIdSetupCompleted extends AuthEvent {}
