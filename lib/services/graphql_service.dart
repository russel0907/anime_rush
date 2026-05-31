import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../config/constants.dart';

final HttpLink httpLink = HttpLink(AppConstants.graphQLEndpoint);

final ValueNotifier<GraphQLClient> graphQLClient = ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);

class GraphQLService {
  final GraphQLClient client;

  GraphQLService(this.client);

  factory GraphQLService.fromProvider(BuildContext context) {
    return GraphQLService(GraphQLProvider.of(context).value);
  }

  Future<QueryResult> query({
    required String document,
    Map<String, dynamic>? variables,
  }) {
    return client.query(
      QueryOptions(
        document: gql(document),
        variables: variables ?? {},
      ),
    );
  }

  Future<List<dynamic>> fetchMediaPage({
    required String queryString,
    int page = 1,
    int perPage = AppConstants.defaultPageSize,
  }) async {
    final result = await query(
      document: queryString,
      variables: {
        'page': page,
        'perPage': perPage,
      },
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data?['Page']?['media'] as List<dynamic>? ?? [];
  }

  Future<List<dynamic>> searchMedia({
    required String searchTerm,
    int page = 1,
    int perPage = AppConstants.defaultPageSize,
  }) async {
    final result = await query(
      document: '''
      query (\$search: String, \$page: Int, \$perPage: Int) {
        Page(page: \$page, perPage: \$perPage) {
          media(search: \$search) {
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
      ''',
      variables: {
        'search': searchTerm,
        'page': page,
        'perPage': perPage,
      },
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data?['Page']?['media'] as List<dynamic>? ?? [];
  }
}
