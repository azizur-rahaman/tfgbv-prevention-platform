import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class FaceIdSetupPage extends StatefulWidget {
  const FaceIdSetupPage({super.key});

  @override
  State<FaceIdSetupPage> createState() => _FaceIdSetupPageState();
}

class _FaceIdSetupPageState extends State<FaceIdSetupPage> {
  bool _isSuccess = false;

  void _onEnableFaceId() {
    // Simulate biometric scan completion
    setState(() {
      _isSuccess = true;
    });
  }

  void _onSkip() {
    context.read<AuthBloc>().add(FaceIdSetupSkipped());
  }

  void _onContinue() {
    context.read<AuthBloc>().add(FaceIdSetupCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _isSuccess ? _buildSuccessView() : _buildSetupView(),
        ),
      ),
    );
  }

  Widget _buildSetupView() {
    return Column(
      key: const ValueKey('setup'),
      children: [
        // App Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Text(
                'Nirvhoy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 48), // Balancing
            ],
          ),
        ),

        // Scanner Illustration
        Expanded(
          child: Center(
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.textSecondary.withAlpha(50),
                  width: 2,
                  style: BorderStyle.none,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Dashed border representation
                  CustomPaint(
                    size: const Size(280, 280),
                    painter: DashedRectPainter(
                      color: AppColors.textSecondary.withAlpha(100),
                    ),
                  ),
                  const Icon(Icons.face, size: 120, color: Colors.white70),

                  // Corners
                  Positioned(
                    top: 24,
                    left: 24,
                    child: _buildCorner(false, false),
                  ),
                  Positioned(
                    top: 24,
                    right: 24,
                    child: _buildCorner(false, true),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 24,
                    child: _buildCorner(true, false),
                  ),
                  Positioned(
                    bottom: 24,
                    right: 24,
                    child: _buildCorner(true, true),
                  ),

                  // Scan Line
                  Positioned(
                    top: 140, // Middle
                    left: 16,
                    right: 16,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent.withAlpha(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryAccent.withAlpha(200),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: const [
              Text(
                'Enable Face Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Use Face ID to unlock your secure locker.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),

        // Actions
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onEnableFaceId,
                  child: const Text(
                    'Enable Face ID',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: _onSkip,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.textSecondary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Skip for Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCorner(bool isBottom, bool isRight) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border(
          top: isBottom
              ? BorderSide.none
              : const BorderSide(color: AppColors.primaryAccent, width: 2),
          bottom: isBottom
              ? const BorderSide(color: AppColors.primaryAccent, width: 2)
              : BorderSide.none,
          left: isRight
              ? BorderSide.none
              : const BorderSide(color: AppColors.primaryAccent, width: 2),
          right: isRight
              ? const BorderSide(color: AppColors.primaryAccent, width: 2)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: (!isBottom && !isRight)
              ? const Radius.circular(8)
              : Radius.zero,
          topRight: (!isBottom && isRight)
              ? const Radius.circular(8)
              : Radius.zero,
          bottomLeft: (isBottom && !isRight)
              ? const Radius.circular(8)
              : Radius.zero,
          bottomRight: (isBottom && isRight)
              ? const Radius.circular(8)
              : Radius.zero,
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      key: const ValueKey('success'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        // Checkmark Icon
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 176,
              height: 176,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withAlpha(12),
                border: Border.all(color: AppColors.success.withAlpha(25)),
              ),
            ),
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withAlpha(25),
                border: Border.all(color: AppColors.success.withAlpha(50)),
              ),
            ),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.success.withAlpha(76),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: const Icon(
                Icons.verified_user,
                color: Colors.white,
                size: 48,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          'Biometric Verified',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Face ID has been successfully linked to your secure locker.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const Spacer(),

        // Footer fixed to bottom
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock, size: 12, color: AppColors.textSecondary),
                  SizedBox(width: 8),
                  Text(
                    'END-TO-END ENCRYPTED',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Painter for dashed border
class DashedRectPainter extends CustomPainter {
  final Color color;

  DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 10.0;
    const dashSpace = 10.0;
    double startX = 0;

    // Top
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }

    // Right
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }

    // Bottom
    startX = size.width;
    while (startX > 0) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX - dashWidth, size.height),
        paint,
      );
      startX -= dashWidth + dashSpace;
    }

    // Left
    startY = size.height;
    while (startY > 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY - dashWidth), paint);
      startY -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
