class MediaTitle {
  final String? romaji;
  final String? english;
  final String? native;
  final String? userPreferred;

  MediaTitle({
    this.romaji,
    this.english,
    this.native,
    this.userPreferred,
  });

  factory MediaTitle.fromJson(Map<String, dynamic> json) {
    return MediaTitle(
      romaji: json['romaji'] as String?,
      english: json['english'] as String?,
      native: json['native'] as String?,
      userPreferred: json['userPreferred'] as String?,
    );
  }

  String get displayTitle => english ?? romaji ?? native ?? 'Unknown';
}
