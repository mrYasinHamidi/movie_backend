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
  final refreshToken = data['refreshToken'] as String?;
  if (refreshToken == null) {
    return Response(
      statusCode: HttpStatus.unauthorized,
      body: 'no refresh token',
    );
  }

  return Response.json(
    body: {
      'accessToken': TokenHelper.generateTokenFromToken(refreshToken, 30),
      'refreshToken': TokenHelper.generateTokenFromToken(refreshToken, 300),
    },
  );
}
