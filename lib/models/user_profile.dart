class UserProfile {
  final String username;
  final String? fullName;
  final String? email;
  final String? location;
  final String? avatarUrl;
  final int followers;
  final int following;
  final int xp;
  final int level;
  final int streak;
  final List<String> achievements;
  final List<int> savedAnimeIds;

  UserProfile({
    this.username = 'Anime Fan',
    this.fullName,
    this.email,
    this.location,
    this.avatarUrl,
    this.followers = 0,
    this.following = 0,
    this.xp = 0,
    this.level = 1,
    this.streak = 0,
    this.achievements = const [],
    this.savedAnimeIds = const [],
  });

  int get xpForNextLevel => level * 100;
  double get xpProgress => xp / xpForNextLevel;

  UserProfile copyWith({
    String? username,
    String? fullName,
    String? email,
    String? location,
    String? avatarUrl,
    int? followers,
    int? following,
    int? xp,
    int? level,
    int? streak,
    List<String>? achievements,
    List<int>? savedAnimeIds,
  }) {
    return UserProfile(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streak: streak ?? this.streak,
      achievements: achievements ?? this.achievements,
      savedAnimeIds: savedAnimeIds ?? this.savedAnimeIds,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] as String? ?? 'Anime Fan',
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      location: json['location'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      followers: json['followers'] as int? ?? 0,
      following: json['following'] as int? ?? 0,
      xp: json['xp'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      streak: json['streak'] as int? ?? 0,
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      savedAnimeIds: (json['savedAnimeIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullName': fullName,
      'email': email,
      'location': location,
      'avatarUrl': avatarUrl,
      'followers': followers,
      'following': following,
      'xp': xp,
      'level': level,
      'streak': streak,
      'achievements': achievements,
      'savedAnimeIds': savedAnimeIds,
    };
  }
}
