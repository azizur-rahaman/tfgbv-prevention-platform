import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthOnboarding extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthOtpVerification extends AuthState {
  final String nationalId;
  final String phoneNumber;

  const AuthOtpVerification({
    required this.nationalId,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [nationalId, phoneNumber];
}

class AuthVerifiedSuccess extends AuthState {}

class AuthAppPasswordSetup extends AuthState {}

class AuthFaceIdSetup extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
