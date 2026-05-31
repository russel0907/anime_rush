import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';
import '../../widgets/common/particle_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ParticleBackground(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                // Logo
                Image.asset(
                  'assets/images/icon.png',
                  width: 150,
                  height: 150,
                ).animate().fadeIn(duration: 600.ms).scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    ),
                // Form Container
                Container(
                  height: MediaQuery.of(context).size.height * 0.62,
                  decoration: const BoxDecoration(
                    color: AppColors.navBarDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                          hint: 'Full Name',
                          icon: Icons.person,
                          delay: 100,
                        ),
                        _buildTextField(
                          hint: 'Username',
                          icon: Icons.person_outline,
                          delay: 200,
                        ),
                        _buildTextField(
                          hint: 'Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          delay: 300,
                        ),
                        _buildTextField(
                          hint: 'Email',
                          icon: Icons.email_outlined,
                          delay: 400,
                        ),
                        // Remember Me
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Remember Me',
                                style: TextStyle(color: AppColors.textPrimary),
                              ),
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                                activeColor: AppColors.accentBlue,
                              ),
                            ],
                          ),
                        ).animate().fadeIn(
                              duration: 400.ms,
                              delay: 500.ms,
                            ),
                        // Sign Up Button
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: AppColors.primaryGradient,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/question');
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(
                              duration: 400.ms,
                              delay: 600.ms,
                            )
                            .slideY(
                              begin: 0.2,
                              end: 0,
                              duration: 400.ms,
                              delay: 600.ms,
                            ),
                        // Login Link
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: AppColors.accentBlue,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ).animate().fadeIn(
                              duration: 400.ms,
                              delay: 700.ms,
                            ),
                      ],
                    ),
                  ),
                ).animate().slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 500.ms,
                      curve: Curves.easeOutCubic,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    int delay = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration.collapsed(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 400.ms,
          delay: delay.ms,
        )
        .slideX(
          begin: -0.1,
          end: 0,
          duration: 400.ms,
          delay: delay.ms,
        );
  }
}
