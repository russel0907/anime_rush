import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/theme.dart';
import '../../widgets/common/countdown_widget.dart';

class AnimeDetailPage extends StatelessWidget {
  final Map<String, dynamic> media;

  const AnimeDetailPage({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    final title = media['title']?['romaji'] ?? 'Unknown';
    final description = media['description'] as String? ?? '';
    final coverImage = media['coverImage']?['large'] as String? ?? '';
    final bannerImage = media['bannerImage'] as String? ?? '';
    final episodes = media['episodes'] as int?;
    final status = media['status'] as String? ?? 'UNKNOWN';
    final format = media['format'] as String? ?? '';
    final season = media['season'] as String?;
    final seasonYear = media['seasonYear'] as int?;
    final nextAiring = media['nextAiringEpisode'] as Map<String, dynamic>?;
    final streamingEpisodes =
        media['streamingEpisodes'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        slivers: [
          // Banner & AppBar
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.navBarDark,
            flexibleSpace: FlexibleSpaceBar(
              background: bannerImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: bannerImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.surfaceDark,
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surfaceDark,
                        child: CachedNetworkImage(
                          imageUrl: coverImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: coverImage,
                      fit: BoxFit.cover,
                    ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.navBarDark,
                    AppColors.backgroundDark,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideX(
                          begin: -0.1,
                          end: 0,
                          duration: 400.ms,
                        ),
                    const SizedBox(height: 8),
                    // Meta info
                    Row(
                      children: [
                        if (format.isNotEmpty) _buildChip(format),
                        if (status.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          _buildChip(_formatStatus(status)),
                        ],
                        if (episodes != null) ...[
                          const SizedBox(width: 8),
                          _buildChip('$episodes eps'),
                        ],
                        if (season != null && seasonYear != null) ...[
                          const SizedBox(width: 8),
                          _buildChip('$season $seasonYear'),
                        ],
                      ],
                    ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                    const SizedBox(height: 16),
                    // Next Airing
                    if (nextAiring != null &&
                        nextAiring['timeUntilAiring'] != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.accentBlue.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.schedule,
                                color: AppColors.accentCyan, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Next episode in: ',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            CountdownWidget(
                              nextAiring['timeUntilAiring'] as int,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                      const SizedBox(height: 16),
                    ],
                    // Description
                    if (description.isNotEmpty) ...[
                      const Text(
                        'Synopsis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
                      const SizedBox(height: 8),
                      Text(
                        _stripHtml(description),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
                      const SizedBox(height: 24),
                    ],
                    // Streaming Episodes
                    if (streamingEpisodes.isNotEmpty) ...[
                      const Text(
                        'Streaming Episodes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
                      const SizedBox(height: 12),
                      ...streamingEpisodes.map((episode) {
                        final epTitle =
                            episode['title'] as String? ?? 'Episode';
                        final thumbnail = episode['thumbnail'] as String? ?? '';
                        final url = episode['url'] as String? ?? '';
                        final site = episode['site'] as String? ?? '';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: thumbnail.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: thumbnail,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 60,
                                      height: 60,
                                      color: AppColors.navBarDark,
                                      child: const Icon(
                                        Icons.play_circle_outline,
                                        color: AppColors.accentBlue,
                                      ),
                                    ),
                            ),
                            title: Text(
                              epTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              site,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 12,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.play_circle_fill,
                              color: AppColors.accentBlue,
                            ),
                            onTap: () {
                              if (url.isNotEmpty) {
                                launchUrl(Uri.parse(url));
                              }
                            },
                          ),
                        ).animate().fadeIn(
                              duration: 300.ms,
                              delay: (600 +
                                      streamingEpisodes.indexOf(episode) * 50)
                                  .ms,
                            );
                      }),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  String _formatStatus(String status) {
    switch (status) {
      case 'RELEASING':
        return 'ONGOING';
      case 'FINISHED':
        return 'FINISHED';
      case 'NOT_YET_RELEASED':
        return 'UPCOMING';
      default:
        return status;
    }
  }

  String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&', '&')
        .replaceAll('<', '<')
        .replaceAll('>', '>')
        .replaceAll('"', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&nbsp;', ' ');
  }
}
