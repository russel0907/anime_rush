import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../config/theme.dart';
import '../../graphql/queries/media_fragments.dart';
import '../../widgets/common/media_grid_card.dart';
import '../../widgets/common/shimmer_loading.dart';

class HomeMangaTabPage extends StatefulWidget {
  final Map<String, dynamic> variables;

  const HomeMangaTabPage({
    required this.variables,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeMangaTabPage> createState() => _HomeMangaTabPageState();
}

class _HomeMangaTabPageState extends State<HomeMangaTabPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Query(
        options: QueryOptions(
          document: gql(MediaFragments.mangaQuery),
          variables: widget.variables,
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
            return const Center(
              child: Text(
                'No manga found',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.accentBlue,
            onRefresh: () async {
              await refetch?.call();
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16,
                      top: MediaQuery.of(context).size.height * 0.08,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.accentBlue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Trending Manga',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: mediaList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
