import 'package:flutter/material.dart';
import '../graphql/queries/media_fragments.dart';
import '../models/media.dart';
import 'graphql_service.dart';

class AnimeService {
  final GraphQLService _graphQLService;

  AnimeService(this._graphQLService);

  factory AnimeService.fromContext(BuildContext context) {
    return AnimeService(GraphQLService.fromProvider(context));
  }

  Future<List<Media>> fetchTrendingAnime({
    int page = 1,
    int perPage = 20,
  }) async {
    final data = await _graphQLService.fetchMediaPage(
      queryString: MediaFragments.animeQuery,
      page: page,
      perPage: perPage,
    );
    return data.map((e) => Media.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Media>> fetchTrendingManga({
    int page = 1,
    int perPage = 20,
  }) async {
    final data = await _graphQLService.fetchMediaPage(
      queryString: MediaFragments.mangaQuery,
      page: page,
      perPage: perPage,
    );
    return data.map((e) => Media.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Media>> fetchTrendingMovies({
    int page = 1,
    int perPage = 20,
  }) async {
    final data = await _graphQLService.fetchMediaPage(
      queryString: MediaFragments.movieQuery,
      page: page,
      perPage: perPage,
    );
    return data.map((e) => Media.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Media>> fetchReleasingAnime({
    int page = 1,
    int perPage = 20,
  }) async {
    final data = await _graphQLService.fetchMediaPage(
      queryString: MediaFragments.releasingAnimeQuery,
      page: page,
      perPage: perPage,
    );
    return data.map((e) => Media.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Media>> searchMedia({
    required String searchTerm,
    int page = 1,
    int perPage = 20,
  }) async {
    final data = await _graphQLService.searchMedia(
      searchTerm: searchTerm,
      page: page,
      perPage: perPage,
    );
    return data.map((e) => Media.fromJson(e as Map<String, dynamic>)).toList();
  }
}
