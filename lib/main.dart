import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/app_theme.dart';
import 'config/theme/app_colors.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/onboarding_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_verification_page.dart';
import 'features/auth/presentation/pages/verification_success_page.dart';
import 'features/auth/presentation/pages/app_password_setup_page.dart';
import 'features/auth/presentation/pages/face_id_setup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TFGBV Prevention Platform',
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => AuthBloc()..add(AppStarted()),
        child: const AuthWrapper(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Handle side effects here if needed
      },
      builder: (context, state) {
        if (state is AuthOnboarding) return const OnboardingPage();
        if (state is AuthUnauthenticated) return const LoginPage();
        if (state is AuthOtpVerification) return const OtpVerificationPage();
        if (state is AuthVerifiedSuccess) {
          return const VerificationSuccessPage();
        }
        if (state is AuthAppPasswordSetup) return const AppPasswordSetupPage();
        if (state is AuthFaceIdSetup) return const FaceIdSetupPage();
        if (state is AuthAuthenticated) return const TestDashboardScreen();
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

// Temporary screen to visualize the new theme
class TestDashboardScreen extends StatelessWidget {
  const TestDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DASHBOARD'),
        leading: const Icon(Icons.security, color: AppColors.primaryAccent),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textSecondary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Search Bar Mockup
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search secure database...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 24),

            // Verified Status Card
            _buildStatusCard(
              title: 'Field Recording_042',
              timestamp: 'Oct 24, 2023 • 14:32',
              statusText: 'VERIFIED',
              statusColor: AppColors.success,
              statusIcon: Icons.verified,
              indicatorColor: AppColors.success,
            ),
            const SizedBox(height: 12),

            // Processing Status Card
            _buildStatusCard(
              title: 'Surveillance Log_89',
              timestamp: 'Oct 24, 2023 • 15:45',
              statusText: 'PROCESSING',
              statusColor: AppColors.warning,
              statusIcon: Icons.sync,
              indicatorColor: AppColors.warning,
            ),
            const SizedBox(height: 12),

            // Critical Status Card example
            _buildStatusCard(
              title: 'Emergency_Beacon_Alpha',
              timestamp: 'Oct 25, 2023 • 01:15',
              statusText: 'CRITICAL',
              statusColor: AppColors.critical,
              statusIcon: Icons.warning_amber_rounded,
              indicatorColor: AppColors.critical,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.critical,
          child: const Icon(Icons.emergency, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundDark,
        selectedItemColor: AppColors.primaryAccent,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'VAULT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'SETTINGS',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String timestamp,
    required String statusText,
    required Color statusColor,
    required IconData statusIcon,
    required Color indicatorColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: indicatorColor, width: 4)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.backgroundDark.withAlpha(128),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.visibility_off,
            color: AppColors.textSecondary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              timestamp,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 14),
                const SizedBox(width: 4),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
