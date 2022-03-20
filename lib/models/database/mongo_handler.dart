import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io' show Platform;

class MongoHandler {
  String host = Platform.environment['MONGO_DART_DRIVER_HOST'] ?? '127.0.0.1';
  String port = Platform.environment['MONGO_DART_DRIVER_PORT'] ?? '27017';
  Db? dbConnection;
  bool isAvailable = false;

  MongoHandler() {
    dbConnection = Db('mongodb://$host:$port/mongo_dart');
  }

  Future closeConnection() async {
    await dbConnection?.close();
    log("[MongoHandler] closed db connection");
  }

  void runMongo() async {
    var authors = <String, Map>{};
    var users = <String, Map>{};
    await dbConnection?.open();
    await dbConnection?.drop();
    print(
        '====================================================================');
    print('>> Adding Authors');
    var collection = dbConnection?.collection('authors');
    await collection?.insertMany([
      {
        'name': 'William Shakespeare',
        'email': 'william@shakespeare.com',
        'age': 587
      },
      {'name': 'Jorge Luis Borges', 'email': 'jorge@borges.com', 'age': 123}
    ]);
    await dbConnection?.ensureIndex('authors',
        name: 'meta', keys: {'_id': 1, 'name': 1, 'age': 1});
    await collection?.find().forEach((v) {
      print(v);
      authors[v['name'].toString()] = v;
    });
    print(
        '====================================================================');
    print('>> Authors ordered by age ascending');
    await collection?.find(where.sortBy('age')).forEach((auth) =>
        print("[${auth['name']}]:[${auth['email']}]:[${auth['age']}]"));
    print(
        '====================================================================');
    print('>> Adding Users');
    var usersCollection = dbConnection?.collection('users');
    await usersCollection?.insertMany([
      {'login': 'jdoe', 'name': 'John Doe', 'email': 'john@doe.com'},
      {'login': 'lsmith', 'name': 'Lucy Smith', 'email': 'lucy@smith.com'}
    ]);
    await dbConnection?.ensureIndex('users', keys: {'login': -1});
    await usersCollection?.find().forEach((user) {
      users[user['login'].toString()] = user;
      print(user);
    });
    print(
        '====================================================================');
    print('>> Users ordered by login descending');
    await usersCollection
        ?.find(where.sortBy('login', descending: true))
        .forEach((user) =>
            print("[${user['login']}]:[${user['name']}]:[${user['email']}]"));
    print(
        '====================================================================');
    print('>> Adding articles');
    var articlesCollection = dbConnection?.collection('articles');
    await articlesCollection?.insertMany([
      {
        'title': 'Caminando por Buenos Aires',
        'body': 'Las callecitas de Buenos Aires tienen ese no se que...',
        'author_id': authors['Jorge Luis Borges']?['_id']
      },
      {
        'title': 'I must have seen thy face before',
        'body': 'Thine eyes call me in a new way',
        'author_id': authors['William Shakespeare']?['_id'],
        'comments': [
          {'user_id': users['jdoe']?['_id'], 'body': 'great article!'}
        ]
      }
    ]);
    print(
        '====================================================================');
    print('>> Articles ordered by title ascending');
    await articlesCollection?.find(where.sortBy('title')).forEach((article) {
      print("[${article['title']}]:[${article['body']}]:"
          "[${article['author_id'].toHexString()}]");
    });
    await closeConnection();
  }
}
