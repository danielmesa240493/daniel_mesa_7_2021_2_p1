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
  String _filter = '';
  bool _isFiltered = false;

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
        actions: <Widget>[
          _isFiltered
          ? IconButton(
            onPressed: _removefilter, 
            icon: Icon(Icons.filter_none)
          )
          : IconButton(
            onPressed: _showfilter, 
            icon: Icon(Icons.filter_alt)
          )
        ],
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
          _isFiltered
          ? 'No hay memes con ese criterio de busqueda.'
          : 'No hay Memes.',
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

  void _removefilter() {
    setState(() {
      _isFiltered = false;
    });
    _getMemes();
  }

  void _showfilter() {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Filtrar Memes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Escriba la primera letra del meme'),
              SizedBox(height: 10,),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Criterio de Búsqueda...',
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search)
                ),
                onChanged: (value){
                    _filter = value;
                },
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancelar')
            ),
            TextButton(
              onPressed: () => _search(), 
              child: Text('Filtrar')
            ),
          ],
        );
      });
  }

  void _search() {
    if(_filter.isEmpty){
      return; 
    }

    List<Meme> filteredList = [];
    for (var meme in _memes) {
      if(meme.submissionTitle.toLowerCase().contains(_filter.toLowerCase())){
        filteredList.add(meme);
      }
    }

    setState(() {
      _memes = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }
}