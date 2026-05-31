import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/theme.dart';

class CountdownWidget extends StatefulWidget {
  final int initialTimeInSeconds;

  const CountdownWidget(this.initialTimeInSeconds, {super.key});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  int remainingTimeInSeconds = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    remainingTimeInSeconds = widget.initialTimeInSeconds;
    startCountdown();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimeInSeconds > 0) {
        setState(() {
          remainingTimeInSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (remainingTimeInSeconds == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'Unavailable',
          style: TextStyle(
            fontSize: 11,
            color: AppColors.error,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentBlue.withOpacity(0.2),
            AppColors.accentCyan.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Text(
          formatTime(remainingTimeInSeconds),
          key: ValueKey(remainingTimeInSeconds),
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.accentCyan,
          ),
        ),
      ),
    );
  }

  String formatTime(int timeInSeconds) {
    int days = (timeInSeconds ~/ (60 * 60 * 24)) % 365;
    int hours = (timeInSeconds ~/ (60 * 60)) % 24;
    int minutes = (timeInSeconds ~/ 60) % 60;
    int seconds = timeInSeconds % 60;

    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }
}
