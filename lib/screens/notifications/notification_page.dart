import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.new_releases,
        'title': 'New Episode Released',
        'subtitle': 'Attack on Titan S4 E12 is now available',
        'time': '2 hours ago',
        'color': AppColors.accentBlue,
      },
      {
        'icon': Icons.celebration,
        'title': 'Achievement Unlocked!',
        'subtitle': 'You watched 100 episodes this month',
        'time': '1 day ago',
        'color': AppColors.gold,
      },
      {
        'icon': Icons.trending_up,
        'title': 'Trending Alert',
        'subtitle': 'One Piece is trending in your region',
        'time': '3 days ago',
        'color': AppColors.accentPurple,
      },
      {
        'icon': Icons.schedule,
        'title': 'Airing Soon',
        'subtitle': 'Demon Slayer S3 starts in 2 days',
        'time': '5 days ago',
        'color': AppColors.accentCyan,
      },
      {
        'icon': Icons.group_add,
        'title': 'Friend Activity',
        'subtitle': 'John started watching Naruto',
        'time': '1 week ago',
        'color': AppColors.accentBlue,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.navBarDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist, color: AppColors.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (notif['color'] as Color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notif['icon'] as IconData,
                  color: notif['color'] as Color,
                ),
              ),
              title: Text(
                notif['title'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                notif['subtitle'] as String,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              trailing: Text(
                notif['time'] as String,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(
                duration: 300.ms,
                delay: (index * 80).ms,
              )
              .slideX(
                begin: 0.1,
                end: 0,
                duration: 300.ms,
                delay: (index * 80).ms,
              );
        },
      ),
    );
  }
}
