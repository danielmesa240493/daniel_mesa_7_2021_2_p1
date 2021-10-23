import 'package:flutter/material.dart';
import 'package:flutter_memes_parcial/models/meme.dart';

class MemeScreen extends StatefulWidget {
  final Meme meme;

  MemeScreen({required this.meme});

  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meme.submissionTitle
        ),
      ),
      body: Center(
        child: Text(
          widget.meme.submissionTitle
        )
      ),
    );
  }
}