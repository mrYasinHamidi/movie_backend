import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

///A helper class for working with jwt token
class TokenHelper {
  ///check a toke expires or not
  static String generateTokenFromToken(String token, int exp) {
    final id = verifyToken(token)['id'] as String;
    return generateToken(id, exp);
  }

  ///generate a new token
  static String generateToken(String id, int exp) {
    return JWT({'id': id}).sign(
      SecretKey('123'),
      expiresIn: Duration(minutes: exp),
    );
  }

  /// check token and return the payload if token valid
  static Map<String, dynamic> verifyToken(String token) {
    final payload = JWT.verify(token, SecretKey('123'));
    return payload.payload as Map<String, dynamic>;
  }
}
