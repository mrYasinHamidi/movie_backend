import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/entities/user.dart';
import 'package:movie_backend/models/user.dart';
import 'package:movie_backend/utils/request_handler.dart';

Future<Response> onRequest(RequestContext context) async {
  return handleRequest(
    context,
    get: _get,
  );
}

FutureOr<Response> _get(RequestContext context) async {
  final user = context.read<UserModel>();
  return Response.json(
    body: UserEntity.fromModel(user).toJson(),
  );
}
