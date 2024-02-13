import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/services/authentication_service.dart';
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

  final username = data['username'] as String?;
  final password = data['password'] as String?;

  if (username == null || password == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final authenticator = await context.read<Future<AuthenticationService>>();
  final user = await authenticator.getUserByCredential(username, password);

  if (user != null) {
    return Response.json(
      body: {
        'access_token': TokenHelper.generateToken(user.id.oid, 30),
        'refresh_token': TokenHelper.generateToken(user.id.oid, 300),
      },
    );
  }

  return Response(
    statusCode: HttpStatus.unauthorized,
    body: 'Email Or password are incorrect',
  );
}
