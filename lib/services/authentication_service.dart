import 'package:dart_frog/dart_frog.dart';
import 'package:movie_backend/models/user.dart';
import 'package:movie_backend/services/database_service.dart';
import 'package:movie_backend/utils/token_helper.dart';
import 'package:mongo_dart/mongo_dart.dart';

/// Authentication helper class
class AuthenticationService {
  ///constructor
  AuthenticationService(this.database);

  ///database
  final DatabaseService database;

  ///verify email and password
  ///if email and password are correct the user will returned
  Future<UserModel?> getUserByCredential(String username, String password) async {
    final json = await database.users.findOne({'username': username});
    if (json != null) {
      final user = UserModel.fromJson(json);
      if (user.password == password) return user;
    }
    return null;
  }

  ///verify email and password
  ///if email and password are correct the user will returned
  Future<UserModel?> getUserByAccessToken(String token) async {
    try {
      final tokenData = TokenHelper.verifyToken(token);
      final id = tokenData['id'] as String;
      final json = await database.users.findOne({'_id': ObjectId.parse(id)});

      if (json != null) {
        return UserModel.fromJson(json);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// injection function
  static Middleware provide() {
    return provider<Future<AuthenticationService>>(
      (context) async => AuthenticationService(
        await context.read<Future<DatabaseService>>(),
      ),
    );
  }

  ///get function
  static Future<AuthenticationService> of(RequestContext context) {
    return context.read<Future<AuthenticationService>>();
  }
}
