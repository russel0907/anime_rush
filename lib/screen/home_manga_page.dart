import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeMangaTabPage extends StatefulWidget {
  final String getMediaTrend;
  final Map<String, dynamic> variables;

  const HomeMangaTabPage({
    required this.getMediaTrend,
    required this.variables,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeMangaTabPage> createState() => _HomeMangaTabPageState();
}

class _HomeMangaTabPageState extends State<HomeMangaTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff121315),
      child: Query(
        options: QueryOptions(
          document: gql(widget.getMediaTrend),
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
                      final media = mediaList[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.5,
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
                                      padding: const EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.36,
                                      child:
                                          Text('${media['title']['romaji']}'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
