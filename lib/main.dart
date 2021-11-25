import 'package:flutter/material.dart';

import 'search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flictionary',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primaryColor: const Color(0xFF091353),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF091353),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.0),
            ),
          ),
        ),
      ),
      home: const SearchScreen(),
    );
  }
}
