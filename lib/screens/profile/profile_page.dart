import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';
import '../../widgets/common/xp_progress_bar.dart';
import '../../widgets/common/streak_flame.dart';
import '../../widgets/common/achievement_badge.dart';
import '../../widgets/common/particle_background.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.navBarDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ParticleBackground(
        particleCount: 15,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Avatar
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/circle-profile.png'),
              ).animate().scale(
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                  ),
              const SizedBox(height: 16),
              const Text(
                'Anime Fan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
              const SizedBox(height: 4),
              const Text(
                'animefan@example.com',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
              const SizedBox(height: 24),
              // XP & Streak
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    XpProgressBar(
                      currentXp: 450,
                      requiredXp: 1000,
                      level: 5,
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.textMuted),
                    const SizedBox(height: 16),
                    const StreakFlame(streak: 7),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 400.ms).slideY(
                    begin: 0.2,
                    end: 0,
                    duration: 400.ms,
                    delay: 400.ms,
                  ),
              const SizedBox(height: 24),
              // Stats
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('Followers', '128'),
                    _buildStat('Following', '64'),
                    _buildStat('Saved', '24'),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
              const SizedBox(height: 24),
              // Achievements
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 600.ms),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AchievementBadge(
                      title: 'First Watch',
                      icon: Icons.play_circle,
                      unlocked: true,
                      showAnimation: true,
                    ),
                    AchievementBadge(
                      title: 'Marathon',
                      icon: Icons.flash_on,
                      unlocked: true,
                    ),
                    AchievementBadge(
                      title: 'Collector',
                      icon: Icons.collections_bookmark,
                      unlocked: false,
                    ),
                    AchievementBadge(
                      title: 'Master',
                      icon: Icons.auto_awesome,
                      unlocked: false,
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 700.ms),
              const SizedBox(height: 24),
              // Settings
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildSettingTile(Icons.person, 'Edit Profile'),
                    const Divider(color: AppColors.textMuted, height: 1),
                    _buildSettingTile(Icons.notifications, 'Notifications'),
                    const Divider(color: AppColors.textMuted, height: 1),
                    _buildSettingTile(Icons.color_lens, 'Theme'),
                    const Divider(color: AppColors.textMuted, height: 1),
                    _buildSettingTile(Icons.info_outline, 'About'),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 800.ms),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentBlue),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textMuted,
      ),
      onTap: () {},
    );
  }
}
