import 'package:flutter/material.dart';
import 'package:flutter_memes_parcial/screens/memes_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memes App',
      home: MemesScreen(),
    );
  }
}
