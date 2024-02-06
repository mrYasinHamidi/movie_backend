import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

///mongo database helper class
class DatabaseService {
  final _db = Db('mongodb://localhost:27017/user');

  ///users collection
  late final users = _db.collection('users');

  ///authors collection
  late final authors = _db.collection('authors');

  ///users books
  late final books = _db.collection('books');

  ///open connection to mongo
  Future<void> open() async {
    if (_db.isConnected == false) {
      await _db.open();
    }
  }

  ///close connection to mongo
  Future<void> close() async {
    if (_db.isConnected == true) {
      await _db.close();
    }
  }

  ///start connection and return an instance
  static Future<DatabaseService> start() async {
    final service = DatabaseService();
    await service.open();
    return service;
  }

  /// injection function
  static Middleware provide() {
    return provider<Future<DatabaseService>>((context) => start());
  }
}
