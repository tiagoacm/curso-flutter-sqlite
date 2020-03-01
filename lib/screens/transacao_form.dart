import 'package:bytebank_persistencia/http/webclient.dart';
import 'package:bytebank_persistencia/http/webclients/transacao_webclient.dart';
import 'package:bytebank_persistencia/models/contato.dart';
import 'package:bytebank_persistencia/models/transacao.dart';
import 'package:flutter/material.dart';

class TransacaoForm extends StatefulWidget {
  final Contato contact;

  TransacaoForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransacaoForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransacaoWebClient _webClient = TransacaoWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.nome,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.numeroConta.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'), onPressed: () {
                     
                      final double value = double.tryParse(_valueController.text);
                      final transacaoCriada = Transacao(value, widget.contact);
                      _webClient.save(transacaoCriada).then((transacao){
                        if(transacao != null){
                          Navigator.pop(context);
                        }
                      });
                  },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
