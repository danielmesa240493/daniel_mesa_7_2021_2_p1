import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_memes_parcial/components/loader_component.dart';
import 'package:flutter_memes_parcial/helpers/constans.dart';
import 'package:flutter_memes_parcial/models/meme.dart';
import 'package:http/http.dart' as http;

class MemesScreen extends StatefulWidget {
  const MemesScreen({ Key? key }) : super(key: key);

  @override
  _MemesScreenState createState() => _MemesScreenState();
}

class _MemesScreenState extends State<MemesScreen> {
  List<Meme> _memes = [];
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _getMemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memes'),
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : Text('Memes'),
      ),
    );
  }

  void _getMemes() async {
    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse('${Constans.apiUrl}/memes/?skip=0&limit=100');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'aplication/json',
        'accept' : 'aplication/json',
      }
    );

    setState(() {
      _showLoader = false;
    });

    print(response.body);
  }

  
}