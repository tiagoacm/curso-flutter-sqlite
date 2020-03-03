import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil usuário'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150,
                    child: Image.network(
                        'https://cdn4.iconfinder.com/data/icons/avatar-circle-1-1/72/91-512.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tiago',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.add_location,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                      Text(
                        'Chavantes-SP',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _ItemPerfil(
                            'Social',
                            Icons.face,
                            cor: Colors.brown,
                          ),
                          _ItemPerfil(
                            'Esporte',
                            Icons.directions_run,
                            cor: Colors.blueAccent,
                          ),
                          _ItemPerfil(
                            'Carro',
                            Icons.directions_car,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _ItemPerfil extends StatelessWidget {
  final String nome;
  final IconData icone;
  final Color cor;

  const _ItemPerfil(this.nome, this.icone, {this.cor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          icone,
          size: 40,
          color: cor,
        ),
        Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            nome,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
    ;
  }
}
