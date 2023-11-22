import 'package:anime_rush/screen/anime_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
  int currentPage = 1; // Initial page number
  int itemsPerPage = 20; // Number of items to fetch per page
  bool isLoadingMore = false; // To prevent multiple requests while loading

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff121315),
      child: Query(
        options: QueryOptions(
          document: gql('''
          {
            Page(page: $currentPage, perPage: $itemsPerPage) {
              media(format: TV) {
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
              }
            }
          }
          '''),
          variables: widget.variables,
        ),
        builder: (
          QueryResult result, {
          Future<QueryResult?> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult?> Function()? refetch,
        }) {
          if (result.hasException) {
            return Text('Error: ${result.exception.toString()}');
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final mediaList = result.data?['Page']['media'];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16,
                      top: MediaQuery.of(context).size.height * 0.08),
                  child: const Text(
                    'Trending Now',
                    style: TextStyle(color: Color(0xff8F8F8F), fontSize: 16),
                  ),
                ),
                if (mediaList != null)
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
                      if (index < mediaList.length) {
                        final media = mediaList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AnimePage(media: media)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Image.network(
                                      media['coverImage']['large'],
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 3,
                                          color: const Color(0xff398AD9),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.36,
                                          child: Text(
                                              '${media['title']['romaji']}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (isLoadingMore) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Center(child: Text('No More Content'));
                      }
                    },
                  ),
                if (!isLoadingMore && mediaList != null && mediaList.length > 0)
                  GestureDetector(
                      onTap: () {
                        loadNextPage();
                      },
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            bottom: MediaQuery.of(context).size.height * 0.06),
                        child: const Text(
                          'Next Page',
                          style: TextStyle(fontSize: 17),
                        ),
                      ))),
              ],
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
        document: gql('''
      {
        Page(page: $currentPage, perPage: $itemsPerPage) {
          media(format: TV) {
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
          }
        }
      }
      '''),
        variables: widget.variables,
      );

      GraphQLClient client = GraphQLProvider.of(context).value;
      client.query(options).then((newResult) {
        setState(() {
          isLoadingMore = false;
          currentPage++;
        });
      });
    }
  }
}
