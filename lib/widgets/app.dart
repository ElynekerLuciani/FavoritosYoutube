import 'package:favoritosyoutube/screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterTube',
      home: HomeScreen(),
    );
  }
}
