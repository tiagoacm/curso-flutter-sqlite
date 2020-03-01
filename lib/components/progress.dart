import 'package:flutter/material.dart';

class Progress extends StatelessWidget {

  final String mensagem;

  Progress({this.mensagem = 'Carregando...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              mensagem,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
