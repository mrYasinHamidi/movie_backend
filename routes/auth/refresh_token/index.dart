import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/utils/request_handler.dart';
import 'package:movie_backend/utils/token_helper.dart';

Future<Response> onRequest(RequestContext context) async {
  return handleRequest(
    context,
    post: _post,
  );
}

FutureOr<Response> _post(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;
  final refreshToken = data['refresh_token'] as String?;
  if (refreshToken == null) {
    return Response(
      statusCode: HttpStatus.unauthorized,
      body: 'no refresh token',
    );
  }

  return Response.json(
    body: {
      'access_token': TokenHelper.generateTokenFromToken(refreshToken, 1),
      'refresh_token': TokenHelper.generateTokenFromToken(refreshToken, 10),
    },
  );
}
