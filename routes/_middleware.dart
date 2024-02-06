import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/services/database_service.dart';

Handler middleware(Handler handler) {
  return handler.use(
    DatabaseService.provide(),
  );
}
