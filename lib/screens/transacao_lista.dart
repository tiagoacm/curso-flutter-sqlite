import 'package:bytebank_persistencia/components/centered_message.dart';
import 'package:bytebank_persistencia/components/progress.dart';
import 'package:bytebank_persistencia/http/webclients/transacao_webclient.dart';
import 'package:bytebank_persistencia/models/transacao.dart';
import 'package:flutter/material.dart';

class TransacaoLista extends StatelessWidget {

  final TransacaoWebClient _webClient = TransacaoWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de transferências'),
      ),
      body: FutureBuilder<List<Transacao>>(
          future: _webClient.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress(mensagem: "Carregando");
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transacao> transacaoLista = snapshot.data;
                  if (transacaoLista.isNotEmpty) {
                    return ListView.builder(
                      itemCount: transacaoLista.length,
                      itemBuilder: (context, index) {
                        final Transacao transacao = transacaoLista[index];
                        return _TransacaoItem(transacao);
                      },
                    );
                  }
                }
                return CenteredMessage(
                  'Nenhuma transação encontrada.',
                  icon: Icons.warning,
                );
                break;
            }
            return CenteredMessage('Ocorreu um erro, tente novamente.');
          }),
    );
  }
}

class _TransacaoItem extends StatelessWidget {
  final Transacao transacao;

  _TransacaoItem(this.transacao);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transacao.value.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          transacao.contato.numeroConta.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
