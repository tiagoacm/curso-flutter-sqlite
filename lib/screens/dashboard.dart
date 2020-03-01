import 'package:bytebank_persistencia/screens/contato_lista.dart';
import 'package:bytebank_persistencia/screens/transacao_lista.dart';
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _ItemDashboard(
                  "Transferência",
                  Icons.monetization_on,
                  onClick: () {
                    _mostrarContatoLista(context);
                  },
                ),
                _ItemDashboard(
                  "Histórico",
                  Icons.description,
                  onClick: () {
                     _mostrarTransacaoLista(context);
                                       },
                                     ),
                                     _ItemDashboard(
                                       "Perfil",
                                       Icons.person,
                                       onClick: () {
                                         print('tela de histórico');
                                       },
                                     ),
                                   ],
                                 ),
                               )
                             ],
                           ),
                         );
                       }
                     
                       
}


void _mostrarContatoLista(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ContatoLista()));
}

void _mostrarTransacaoLista(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TransacaoLista()));  
}

class _ItemDashboard extends StatelessWidget {
  final String nome;
  final IconData icone;
  final Function onClick;

  _ItemDashboard(
    this.nome, 
    this.icone, 
    {@required this.onClick}
  ) : assert(icone != null),
      assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onClick();
          //chamar outra tela
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContatoLista()));
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
                icone,
                color: Colors.white,
                size: 32.0,
              ),
              Text(
                nome,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
