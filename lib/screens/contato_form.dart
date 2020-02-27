import 'package:bytebank_persistencia/dao/contato_dao.dart';
import 'package:bytebank_persistencia/database/app_database.dart';
import 'package:bytebank_persistencia/models/contato.dart';
import 'package:flutter/material.dart';

class ContatoForm extends StatefulWidget {

  @override
  _ContatoFormState createState() => _ContatoFormState();
}

class _ContatoFormState extends State<ContatoForm> {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();
  final ContatoDao _dao = ContatoDao();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Novo contato'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _numeroContaController,
                  decoration: InputDecoration(
                    labelText: 'Número da conta',
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Adicionar'),
                    onPressed: () {
                      
                      // pegar as informações do TextInput
                      final String nomeContato = _nomeController.text;
                      final int numeroConta = int.tryParse(_numeroContaController.text);
                      
                      //cria objeto de Contato
                      
                      if (nomeContato != null && numeroConta != null) {
                        final Contato novoContato = Contato(0, nomeContato, numeroConta);
                        _dao.salvar(novoContato).then((id)=>Navigator.pop(context));                  
                        //devolve a informação para lista
                        //Navigator.pop(context, novoContato);  
                      } else {                       
                         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Informe nome e número da conta.', style: TextStyle(fontSize: 18),))); 
                      }
                      

                      

                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
