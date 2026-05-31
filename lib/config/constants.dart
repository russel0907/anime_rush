class AppConstants {
  // API
  static const String graphQLEndpoint = 'https://graphql.anilist.co';
  static const int defaultPageSize = 20;
  static const int defaultPage = 1;

  // Pagination
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.7;

  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Sizes
  static const double appBarHeight = 56.0;
  static const double bottomNavIconSize = 36.0;
  static const double cardBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;

  // Streak & XP
  static const int xpPerAnimeWatched = 50;
  static const int xpPerEpisode = 10;
  static const int xpDailyLogin = 20;
  static const int levelsPerBadge = 5;

  // Storage Keys
  static const String userProfileKey = 'user_profile';
  static const String searchHistoryKey = 'search_history';
  static const String savedAnimeKey = 'saved_anime';
}
