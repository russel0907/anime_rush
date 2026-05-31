import 'media_title.dart';
import 'next_airing_episode.dart';
import 'streaming_episode.dart';

enum MediaFormat { TV, MOVIE, MANGA, UNKNOWN }

enum MediaStatus { RELEASING, FINISHED, NOT_YET_RELEASED, CANCELLED, UNKNOWN }

class Media {
  final int id;
  final MediaTitle title;
  final String? description;
  final MediaFormat format;
  final MediaStatus status;
  final String? coverImageLarge;
  final String? coverImageMedium;
  final String? bannerImage;
  final int? episodes;
  final int? chapters;
  final int? volumes;
  final String? season;
  final int? seasonYear;
  final NextAiringEpisode? nextAiringEpisode;
  final List<StreamingEpisode> streamingEpisodes;

  Media({
    required this.id,
    required this.title,
    this.description,
    this.format = MediaFormat.UNKNOWN,
    this.status = MediaStatus.UNKNOWN,
    this.coverImageLarge,
    this.coverImageMedium,
    this.bannerImage,
    this.episodes,
    this.chapters,
    this.volumes,
    this.season,
    this.seasonYear,
    this.nextAiringEpisode,
    this.streamingEpisodes = const [],
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] as int,
      title: MediaTitle.fromJson(json['title'] as Map<String, dynamic>),
      description: json['description'] as String?,
      format: _parseFormat(json['format'] as String?),
      status: _parseStatus(json['status'] as String?),
      coverImageLarge: json['coverImage']?['large'] as String?,
      coverImageMedium: json['coverImage']?['medium'] as String?,
      bannerImage: json['bannerImage'] as String?,
      episodes: json['episodes'] as int?,
      chapters: json['chapters'] as int?,
      volumes: json['volumes'] as int?,
      season: json['season'] as String?,
      seasonYear: json['seasonYear'] as int?,
      nextAiringEpisode: NextAiringEpisode.fromJson(
        json['nextAiringEpisode'] as Map<String, dynamic>?,
      ),
      streamingEpisodes: (json['streamingEpisodes'] as List<dynamic>?)
              ?.map(
                (e) => StreamingEpisode.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  static MediaFormat _parseFormat(String? format) {
    switch (format) {
      case 'TV':
        return MediaFormat.TV;
      case 'MOVIE':
        return MediaFormat.MOVIE;
      case 'MANGA':
        return MediaFormat.MANGA;
      default:
        return MediaFormat.UNKNOWN;
    }
  }

  static MediaStatus _parseStatus(String? status) {
    switch (status) {
      case 'RELEASING':
        return MediaStatus.RELEASING;
      case 'FINISHED':
        return MediaStatus.FINISHED;
      case 'NOT_YET_RELEASED':
        return MediaStatus.NOT_YET_RELEASED;
      case 'CANCELLED':
        return MediaStatus.CANCELLED;
      default:
        return MediaStatus.UNKNOWN;
    }
  }

  String get statusText {
    switch (status) {
      case MediaStatus.RELEASING:
        return 'ONGOING';
      case MediaStatus.FINISHED:
        return 'FINISHED';
      case MediaStatus.NOT_YET_RELEASED:
        return 'UPCOMING';
      case MediaStatus.CANCELLED:
        return 'CANCELLED';
      case MediaStatus.UNKNOWN:
        return 'UNKNOWN';
    }
  }

  int get episodeCount {
    if (nextAiringEpisode?.episode != null) {
      return nextAiringEpisode!.episode!;
    }
    return episodes ?? 0;
  }

  bool get hasStreamingEpisodes => streamingEpisodes.isNotEmpty;

  bool get hasBannerImage => bannerImage != null && bannerImage!.isNotEmpty;
}
