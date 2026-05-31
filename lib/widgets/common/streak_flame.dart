import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class StreakFlame extends StatelessWidget {
  final int streak;

  const StreakFlame({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.local_fire_department,
          color: streak > 0 ? AppColors.gold : AppColors.textMuted,
          size: 28,
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shake(
              duration: 1500.ms,
            ),
        const SizedBox(width: 4),
        Text(
          '$streak',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: streak > 0 ? AppColors.gold : AppColors.textMuted,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'day streak',
          style: TextStyle(
            fontSize: 12,
            color: streak > 0 ? AppColors.gold : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
