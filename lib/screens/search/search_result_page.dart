import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../config/theme.dart';
import '../../graphql/queries/media_fragments.dart';
import '../../widgets/common/media_grid_card.dart';
import '../../widgets/common/shimmer_loading.dart';

class SearchResultPage extends StatelessWidget {
  final String searchTerm;

  const SearchResultPage({super.key, required this.searchTerm});

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
        title: Text(
          'Search: $searchTerm',
          style: const TextStyle(color: Colors.white, fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(MediaFragments.searchQuery),
          variables: {
            'search': searchTerm,
            'page': 1,
            'perPage': 20,
          },
        ),
        builder: (
          QueryResult result, {
          Future<QueryResult?> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult?> Function()? refetch,
        }) {
          if (result.hasException) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      color: AppColors.error, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${result.exception.toString()}',
                    style: const TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => refetch?.call(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (result.isLoading) {
            return const ShimmerGrid();
          }

          final mediaList = result.data?['Page']?['media'] as List<dynamic>?;

          if (mediaList == null || mediaList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off,
                      color: AppColors.textMuted, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'No results found for "$searchTerm"',
                    style: const TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: mediaList.length,
            itemBuilder: (context, index) {
              final media = mediaList[index];
              return MediaGridCard(
                media: media,
                index: index,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/anime-detail',
                    arguments: media,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
