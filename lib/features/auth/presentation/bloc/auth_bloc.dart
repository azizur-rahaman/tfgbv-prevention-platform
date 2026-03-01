import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<OnboardingCompleted>(_onOnboardingCompleted);
    on<LoginRequested>(_onLoginRequested);
    on<OtpSubmitted>(_onOtpSubmitted);
    on<VerificationAcknowledged>(_onVerificationAcknowledged);
    on<AppPasswordSet>(_onAppPasswordSet);
    on<FaceIdSetupRequested>(_onFaceIdSetupRequested);
    on<FaceIdSetupSkipped>(_onFaceIdSetupSkipped);
    on<FaceIdSetupCompleted>(_onFaceIdSetupCompleted);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    // For now, assume a new user starting at Onboarding
    emit(AuthOnboarding());
  }

  void _onOnboardingCompleted(
    OnboardingCompleted event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthUnauthenticated());
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    emit(
      AuthOtpVerification(
        nationalId: event.nationalId,
        phoneNumber: event.phoneNumber,
      ),
    );
  }

  void _onOtpSubmitted(OtpSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, transition to AuthVerifiedSuccess first, then after a delay to AppPasswordSetup
    // Emitting Success state momentarily handles success UI
    emit(AuthVerifiedSuccess());
  }

  void _onVerificationAcknowledged(
    VerificationAcknowledged event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthAppPasswordSetup());
  }

  void _onAppPasswordSet(AppPasswordSet event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthFaceIdSetup());
  }

  void _onFaceIdSetupRequested(
    FaceIdSetupRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Implement native face ID triggering here later
    // Once successful, emit AppPasswordSet
    emit(AuthAuthenticated());
  }

  void _onFaceIdSetupSkipped(
    FaceIdSetupSkipped event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthAuthenticated());
  }

  void _onFaceIdSetupCompleted(
    FaceIdSetupCompleted event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthAuthenticated());
  }
}
