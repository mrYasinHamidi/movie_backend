import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:movie_backend/models/user.dart';
import 'package:movie_backend/services/authentication_service.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<UserModel>(
      authenticator: (context, token) async {
        final authenticator = await AuthenticationService.of(context);
        return authenticator.getUserByAccessToken(token);
      },
    ),
  );
}
