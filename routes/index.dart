import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/services/database_service.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await context.read<Future<DatabaseService>>();
  final users =  await db.users.find().toList();
  return Response(body: '${users}');
}
