import 'package:flutter/material.dart';

class MemeScreen extends StatefulWidget {
  const MemeScreen({ Key? key }) : super(key: key);

  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( 
        child: Text('Meme Screen')
      ),
    );
  }
}