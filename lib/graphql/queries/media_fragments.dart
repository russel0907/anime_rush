class MediaFragments {
  static const String coreMediaFields = '''
  id
  description
  title {
    romaji
    english
    native
    userPreferred
  }
  format
  coverImage {
    large
    medium
  }
  bannerImage
  season
  seasonInt
  seasonYear
  episodes
  status
  volumes
  chapters
  nextAiringEpisode {
    id
    episode
    timeUntilAiring
    media {
      title {
        romaji
        english
        native
        userPreferred
      }
    }
  }
  streamingEpisodes {
    title
    thumbnail
    url
    site
  }
''';

  static const String animeQuery = '''
  query (\$page: Int, \$perPage: Int) {
    Page(page: \$page, perPage: \$perPage) {
      media(format: TV) {
        $coreMediaFields
      }
    }
  }
  ''';

  static const String mangaQuery = '''
  query (\$page: Int, \$perPage: Int) {
    Page(page: \$page, perPage: \$perPage) {
      media(format: MANGA) {
        $coreMediaFields
      }
    }
  }
  ''';

  static const String movieQuery = '''
  query (\$page: Int, \$perPage: Int) {
    Page(page: \$page, perPage: \$perPage) {
      media(format: MOVIE) {
        $coreMediaFields
      }
    }
  }
  ''';

  static const String releasingAnimeQuery = '''
  query (\$page: Int, \$perPage: Int) {
    Page(page: \$page, perPage: \$perPage) {
      media(format: TV, status: RELEASING) {
        $coreMediaFields
      }
    }
  }
  ''';

  static const String searchQuery = '''
  query (\$search: String, \$page: Int, \$perPage: Int) {
    Page(page: \$page, perPage: \$perPage) {
      media(search: \$search) {
        $coreMediaFields
      }
    }
  }
  ''';
}
