import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:effectivess_app/views/screen_day_view.dart';
import 'package:effectivess_app/models/database/database.dart';

import 'package:effectivess_app/models/database/mongo_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // create single connection to database using provider
    Provider<MongoHandler>(
      create: (context) => MongoHandler(),
      child: const MyApp(),
      dispose: (context, db) => db.closeConnection(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time-It',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: DayViewScreen.today(),
    );
  }
}
