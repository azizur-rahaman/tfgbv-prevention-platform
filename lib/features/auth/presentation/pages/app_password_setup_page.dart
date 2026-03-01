import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class AppPasswordSetupPage extends StatefulWidget {
  const AppPasswordSetupPage({super.key});

  @override
  State<AppPasswordSetupPage> createState() => _AppPasswordSetupPageState();
}

class _AppPasswordSetupPageState extends State<AppPasswordSetupPage> {
  String _pin = '';
  final int _pinLength = 6;

  void _onKeypadPressed(String val) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += val;
      });
      if (_pin.length == _pinLength) {
        // Automatically submit
        context.read<AuthBloc>().add(AppPasswordSet(_pin));
      }
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(
                top: 48.0,
                bottom: 32.0,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent.withAlpha(25),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryAccent.withAlpha(50),
                      ),
                    ),
                    child: const Icon(
                      Icons.lock,
                      color: AppColors.primaryAccent,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Create App Passcode',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This PIN protects your evidence locker. Ensure it is unique and difficult to guess.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // PIN Dots
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pinLength, (index) {
                    bool isFilled = index < _pin.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled
                            ? AppColors.primaryAccent
                            : Colors.transparent,
                        border: isFilled
                            ? null
                            : Border.all(
                                color: Colors.white.withAlpha(50),
                                width: 2,
                              ),
                        boxShadow: isFilled
                            ? [
                                BoxShadow(
                                  color: AppColors.primaryAccent.withAlpha(128),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48.0,
                vertical: 32.0,
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildKeypadButton('1', ''),
                  _buildKeypadButton('2', 'ABC'),
                  _buildKeypadButton('3', 'DEF'),
                  _buildKeypadButton('4', 'GHI'),
                  _buildKeypadButton('5', 'JKL'),
                  _buildKeypadButton('6', 'MNO'),
                  _buildKeypadButton('7', 'PQRS'),
                  _buildKeypadButton('8', 'TUV'),
                  _buildKeypadButton('9', 'WXYZ'),
                  const SizedBox.shrink(), // Empty space
                  _buildKeypadButton('0', ''),
                  // Backspace button
                  InkWell(
                    onTap: _onBackspacePressed,
                    borderRadius: BorderRadius.circular(16),
                    child: const Center(
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Security Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.verified_user,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'MILITARY GRADE ENCRYPTION',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String number, String letters) {
    return Material(
      color: AppColors.backgroundLight.withAlpha(100),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _onKeypadPressed(number),
        splashColor: AppColors.primaryAccent.withAlpha(50),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withAlpha(26)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              if (letters.isNotEmpty)
                Text(
                  letters,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
