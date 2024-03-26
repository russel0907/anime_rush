import 'dart:async';

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
  int currentPage = 1;
  int itemsPerPage = 20;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  List<dynamic> mediaList = [];

  late GraphQLClient client;

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadNextPage();
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    client = GraphQLProvider.of(context).value;
    loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff181818),
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

            if (result.isLoading && mediaList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (mediaList.isEmpty) {
              return const Center(child: Text('No Content'));
            }

            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            top: MediaQuery.of(context).size.height * 0.03),
                        child: Text(
                          'Upcoming Episodes'.toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xff8F8F8F),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20, top: 20),
                        child: Image.asset(
                          'assets/images/icon-2.png',
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Text(
                      'Dont miss the latest episodes. Check out whats coming soon.',
                      style: TextStyle(color: Color(0xff8F8F8F), fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: mediaList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final media = mediaList[index];

                        int timeUntilAiring = media['nextAiringEpisode'] != null
                            ? media['nextAiringEpisode']['timeUntilAiring'] ?? 0
                            : 0;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff181818),
                                Color(0xff1e1e1e),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(
                              color: const Color(0xff202020),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: SizedBox(
                                  width: 112,
                                  height: 112,
                                  child: Image.network(
                                    media['coverImage']['large'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        media['title']['english'] ??
                                            media['title']['romaji'],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    CountdownWidget(timeUntilAiring),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (isLoadingMore)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          },
        ),
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
      );

      client.query(options).then((newResult) {
        setState(() {
          isLoadingMore = false;
          currentPage++;
          final newMediaList = newResult.data?['Page']['media'];
          if (newMediaList != null) {
            mediaList.addAll(newMediaList);
          }
        });
      });
    }
  }
}

class CountdownWidget extends StatefulWidget {
  final int initialTimeInSeconds;

  const CountdownWidget(this.initialTimeInSeconds, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  int remainingTimeInSeconds = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    remainingTimeInSeconds = widget.initialTimeInSeconds;
    startCountdown();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimeInSeconds > 0) {
        setState(() {
          remainingTimeInSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (remainingTimeInSeconds == 0) {
      return const Text('Unavailable Time Airing');
    } else {
      return Text(
        formatTime(remainingTimeInSeconds),
        style: const TextStyle(fontSize: 11),
      );
    }
  }

  String formatTime(int timeInSeconds) {
    int days = (timeInSeconds ~/ (60 * 60 * 24)) % 365;
    int hours = (timeInSeconds ~/ (60 * 60)) % 24;
    int minutes = (timeInSeconds ~/ 60) % 60;
    int seconds = timeInSeconds % 60;

    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }
}
