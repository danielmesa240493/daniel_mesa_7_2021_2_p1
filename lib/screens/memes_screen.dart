import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memes_parcial/components/loader_component.dart';
import 'package:flutter_memes_parcial/helpers/constans.dart';
import 'package:flutter_memes_parcial/models/meme.dart';
import 'package:flutter_memes_parcial/screens/meme_screen.dart';
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
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
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

    var body = response.body;
    var decodedJson = jsonDecode(body);
    if(decodedJson != null){
      for (var item in decodedJson['data']) {
        _memes.add(Meme.fromJson(item));
      }
    }

    print(_memes);
  }

  Widget _getContent() {
    return _memes.length == 0
     ? _noContent()
     : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          'No hay Memes.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _getListView() {
    return ListView(
      children: _memes.map((e) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => MemeScreen(
                    meme: e,
                  )
                )
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    e.submissionTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    e.submissionUrl,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}