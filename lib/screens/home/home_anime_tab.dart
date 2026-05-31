import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../config/theme.dart';
import '../../graphql/queries/media_fragments.dart';
import '../../widgets/common/media_grid_card.dart';
import '../../widgets/common/shimmer_loading.dart';

class HomeAnimeTabPage extends StatefulWidget {
  final Map<String, dynamic> variables;

  const HomeAnimeTabPage({
    required this.variables,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeAnimeTabPage> createState() => _HomeAnimeTabPageState();
}

class _HomeAnimeTabPageState extends State<HomeAnimeTabPage> {
  int currentPage = 1;
  int itemsPerPage = 20;
  bool isLoadingMore = false;
  final List<dynamic> _allMedia = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Query(
        options: QueryOptions(
          document: gql(MediaFragments.animeQuery),
          variables: {
            'page': currentPage,
            'perPage': itemsPerPage,
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

          if (result.isLoading && _allMedia.isEmpty) {
            return const ShimmerGrid();
          }

          final mediaList = result.data?['Page']?['media'] as List<dynamic>?;
          if (mediaList != null && _allMedia.isEmpty) {
            _allMedia.addAll(mediaList);
          }

          if (_allMedia.isEmpty) {
            return const Center(
              child: Text(
                'No anime found',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.accentBlue,
            onRefresh: () async {
              setState(() {
                currentPage = 1;
                _allMedia.clear();
              });
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
                          'Trending Now',
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
                    itemCount: _allMedia.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final media = _allMedia[index];
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
                  if (isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentBlue,
                          strokeWidth: 2,
                        ),
                      ),
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

  void loadNextPage() {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });

      final options = QueryOptions(
        document: gql(MediaFragments.animeQuery),
        variables: {
          'page': currentPage + 1,
          'perPage': itemsPerPage,
        },
      );

      GraphQLClient client = GraphQLProvider.of(context).value;
      client.query(options).then((newResult) {
        if (mounted) {
          setState(() {
            isLoadingMore = false;
            currentPage++;
            final newMedia =
                newResult.data?['Page']?['media'] as List<dynamic>?;
            if (newMedia != null) {
              _allMedia.addAll(newMedia);
            }
          });
        }
      });
    }
  }
}
