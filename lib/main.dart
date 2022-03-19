import 'package:flutter/material.dart';
import 'package:effectivess_app/views/screen_day_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
