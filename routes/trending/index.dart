import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/utils/request_handler.dart';
import 'package:tmdb_api/tmdb_api.dart';

Future<Response> onRequest(RequestContext context) async {
  return handleRequest(
    context,
    get: _get,
  );
}

FutureOr<Response> _get(RequestContext context) async {
  final movie = TMDB(
    ApiKeys(
      '5ac2a4d5e1a55902993e0b35793c149b',
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YWMyYTRkNWUxYTU1OTAyOTkzZTBiMzU3OTNjMTQ5YiIsInN1YiI6IjYyZWFjNTVkNDgzMzNhMDA1OWZiMjBiOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4mE_w-em27mBo2y5OfWC9XpD5C6DSY0djGr0YAZGxHI',
    ),
  );
  return Response.json(
    body: await movie.v3.trending.getTrending(),
  );
}
