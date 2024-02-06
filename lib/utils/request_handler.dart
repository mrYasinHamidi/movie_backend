import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// handler callback
typedef RequestHandlerCallback = FutureOr<Response> Function(
  RequestContext context,
);

/// handle incoming request for different HTTP methods
FutureOr<Response> handleRequest(
  RequestContext context, {
  RequestHandlerCallback? post,
  RequestHandlerCallback? get,
  RequestHandlerCallback? put,
  RequestHandlerCallback? delete,
}) async {
  final handler = switch (context.request.method) {
    HttpMethod.get => get,
    HttpMethod.post => post,
    HttpMethod.put => put,
    HttpMethod.delete => delete,
    _ => null
  };
  return handler?.call(context) ??
      Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
}
