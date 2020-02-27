import 'package:bytebank_persistencia/screens/contato_lista.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('imagem/logo.png'), 
               ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  //chamar outra tela
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ContatoLista()));
                },
                child: Container(
                  //definir tamanho do container
                  padding: EdgeInsets.all(8.0),
                  width: 150,
                  height: 100,
                  color: Theme.of(context).primaryColor,
                  //definir coluna e objetos dentro da coluna
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.people,
                        color: Colors.white,
                        size: 32.0,
                      ),
                      Text(
                        "Contatos",
                        style: TextStyle(color: Colors.white, fontSize: 16.0 ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}