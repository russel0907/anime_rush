class StreamingEpisode {
  final String? title;
  final String? thumbnail;
  final String? url;
  final String? site;

  StreamingEpisode({
    this.title,
    this.thumbnail,
    this.url,
    this.site,
  });

  factory StreamingEpisode.fromJson(Map<String, dynamic> json) {
    return StreamingEpisode(
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] as String?,
      url: json['url'] as String?,
      site: json['site'] as String?,
    );
  }

  String get episodeNumber {
    if (title == null) return '';
    final parts = title!.split(' - ');
    return parts.isNotEmpty ? parts[0] : '';
  }

  String get episodeTitle {
    if (title == null) return '';
    final parts = title!.split(' - ');
    return parts.length > 1 ? parts[1] : title!;
  }
}
