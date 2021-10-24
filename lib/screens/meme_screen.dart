import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memes_parcial/components/loader_component.dart';
import 'package:flutter_memes_parcial/models/meme.dart';

class MemeScreen extends StatefulWidget {
  final Meme meme;

  MemeScreen({required this.meme});

  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meme.submissionTitle
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _showMemeInfo(),
            ],
          ),
          _showLoader ? LoaderComponent(text: 'Cargando...',) : Container(),
        ],
      ),
    );
  }

  Widget _showMemeInfo() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text('URL Image: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              widget.meme.submissionUrl,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
            Text('Autor: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              widget.meme.author,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
            Text('Fecha de Creación: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              widget.meme.created,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
            Text('Link: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              widget.meme.permalink,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
            Text('ID: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              widget.meme.submissionId,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
            Text('Marca de Tiempo: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              widget.meme.timestamp,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}