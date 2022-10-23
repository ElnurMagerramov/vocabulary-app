import 'package:flutter/material.dart';
import 'package:localhost/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vacabulary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SQLite());
  }
}
