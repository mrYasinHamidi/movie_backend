import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/models/user.dart';
import 'package:movie_backend/services/database_service.dart';
import 'package:movie_backend/utils/request_handler.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  return handleRequest(
    context,
    post: _post,
  );
}

FutureOr<Response> _post(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;

  final username = data['username'] as String?;
  final email = data['email'] as String?;
  final password = data['password'] as String?;

  if (email == null || password == null || username == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final db = await context.read<Future<DatabaseService>>();
  if ((await db.users.findOne({'email': email})) != null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Email already registered',
    );
  }
  if ((await db.users.findOne({'username': username})) != null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Username already registered',
    );
  }
  final user = UserModel(
    id: ObjectId(),
    email: email,
    password: password,
    username: username,
  );

  await db.users.insert(user.toJson());
  return Response(body: 'User successfully created');
}
