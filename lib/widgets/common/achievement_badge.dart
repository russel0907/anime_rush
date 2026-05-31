import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class AchievementBadge extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool unlocked;
  final bool showAnimation;

  const AchievementBadge({
    super.key,
    required this.title,
    required this.icon,
    this.unlocked = false,
    this.showAnimation = false,
  });

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: unlocked
            ? const LinearGradient(colors: AppColors.primaryGradient)
            : null,
        color: unlocked ? null : AppColors.surfaceDark,
        border: Border.all(
          color: unlocked ? AppColors.accentBlue : AppColors.textMuted,
          width: 2,
        ),
        boxShadow: unlocked
            ? [
                BoxShadow(
                  color: AppColors.accentBlue.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Icon(
        icon,
        color: unlocked ? Colors.white : AppColors.textMuted,
        size: 28,
      ),
    );

    if (showAnimation && unlocked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          badge.animate().scale(
                duration: 600.ms,
                curve: Curves.elasticOut,
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
              ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: unlocked ? AppColors.textPrimary : AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        badge,
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: unlocked ? AppColors.textPrimary : AppColors.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
