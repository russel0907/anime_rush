import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class Question2Page extends StatefulWidget {
  const Question2Page({super.key});

  @override
  State<Question2Page> createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/question_bg_image_2.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 28.0,
            right: 28,
            bottom: 42,
            top: 28,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 60,
                  height: 60,
                ).animate().fadeIn(duration: 400.ms),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(children: [
                  const Text(
                    'Continue questionnaire or skip for now?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(
                        duration: 500.ms,
                        delay: 200.ms,
                      )
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        duration: 500.ms,
                        delay: 200.ms,
                      ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton(
                        label: 'Yes',
                        isPrimary: true,
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                        delay: 400,
                      ),
                      _buildButton(
                        label: 'Skip',
                        isPrimary: false,
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                        delay: 500,
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
    int delay = 0,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(colors: AppColors.primaryGradient)
            : null,
        color: isPrimary ? null : AppColors.navBarDark,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: TextButton(
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 400.ms,
          delay: delay.ms,
        )
        .slideY(
          begin: 0.3,
          end: 0,
          duration: 400.ms,
          delay: delay.ms,
        );
  }
}
