import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NotificationPage extends StatefulWidget {
  final Map<String, dynamic> variables;

  const NotificationPage({
    super.key,
    required this.variables,
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int currentPage = 1; // Initial page number
  int itemsPerPage = 20; // Number of items to fetch per page
  bool isLoadingMore = false; // To prevent multiple requests while loading

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff121315),
        child: Query(
          options: QueryOptions(
            document: gql('''
            {
              Page(page: $currentPage, perPage: $itemsPerPage) {
                media(format: TV, status:RELEASING) {
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
                      'Airing Soon',
                      style: TextStyle(color: Color(0xff8F8F8F), fontSize: 16),
                    ),
                  ),
                  if (mediaList != null)
                    ListView.builder(
                      itemCount: mediaList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index < mediaList.length) {
                          final media = mediaList[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Image.network(
                                      media['coverImage']['large'],
                                      fit: BoxFit.cover,
                                      width: 96,
                                      height: 96,
                                    ),
                                  ),
                                  Text(
                                    media['nextAiringEpisode'] != null
                                        ? media['nextAiringEpisode']
                                                    ['timeUntilAiring'] !=
                                                null
                                            ? media['nextAiringEpisode']
                                                    ['timeUntilAiring']
                                                .toString()
                                            : 'No Available Yet'
                                        : 'No Available Yet',
                                  )
                                ],
                              ),
                            ),
                          );
                        } else if (isLoadingMore) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(child: Text('No More Content'));
                        }
                      },
                    ),
                  if (!isLoadingMore &&
                      mediaList != null &&
                      mediaList.length > 0)
                    GestureDetector(
                        onTap: () {},
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: const Text(
                            'Load More',
                            style: TextStyle(fontSize: 17),
                          ),
                        ))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
