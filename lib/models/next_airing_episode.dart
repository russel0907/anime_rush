class NextAiringEpisode {
  final int? id;
  final int? episode;
  final int? timeUntilAiring;

  NextAiringEpisode({
    this.id,
    this.episode,
    this.timeUntilAiring,
  });

  factory NextAiringEpisode.fromJson(Map<String, dynamic>? json) {
    if (json == null) return NextAiringEpisode();
    return NextAiringEpisode(
      id: json['id'] as int?,
      episode: json['episode'] as int?,
      timeUntilAiring: json['timeUntilAiring'] as int?,
    );
  }
}
