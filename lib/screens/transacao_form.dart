import 'dart:async';

import 'package:bytebank_persistencia/components/progress.dart';
import 'package:bytebank_persistencia/components/response_dialog.dart';
import 'package:bytebank_persistencia/components/transacao_auth_dialog.dart';
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
  bool _progressEnviando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova transferência'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _progressEnviando,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    mensagem: 'Enviando...',
                  ),
                ),
              ),
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
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transferir'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transacaoCriada = Transacao(value, widget.contact);

                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransacaoAuthDialog(
                                onConfirm: (String password) async {
                              Transacao transacao = await _enviarPost(
                                  transacaoCriada, password, context);

                              _mostrarMensagemSucesso(transacao, context);
                            });
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

  Future<Transacao> _enviarPost(Transacao transacaoCriada, String password, BuildContext context) async {
    setState(() {
      _progressEnviando = true;
    });
    
    final Transacao transacao = await _webClient.save(transacaoCriada, password)
    .catchError((e) {
      _mostrarMensagemErro(context,mensagem: 'Não foi possível chamar funcionalidade. TIMEOUT');
    }, test: (e) => e is TimeoutException)
    .catchError((e) {
      _mostrarMensagemErro(context, mensagem: e.message);
    }, test: (e) => e is Exception)
    .whenComplete((){
        setState(() {
          _progressEnviando = false;
        });
    });


    return transacao;
  }

  void _mostrarMensagemErro(BuildContext context,
      {String mensagem = 'Erro desconhecido.'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(mensagem);
        });
  }

  Future _mostrarMensagemSucesso(
      Transacao transacao, BuildContext context) async {
    if (transacao != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transação efetuada com sucesso.');
          });
      Navigator.pop(context);
    }
  }
}
