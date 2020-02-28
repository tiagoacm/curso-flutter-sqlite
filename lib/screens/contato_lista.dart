import 'package:bytebank_persistencia/dao/contato_dao.dart';
import 'package:bytebank_persistencia/models/contato.dart';
import 'package:bytebank_persistencia/screens/contato_form.dart';
import 'package:flutter/material.dart';

class ContatoLista extends StatefulWidget {
  @override
  _ContatoListaState createState() => _ContatoListaState();
}

class _ContatoListaState extends State<ContatoLista> {
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<Contato>>(
          initialData: List(),
          future: _dao.buscarTodos(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Carregando...',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contato> listaContatos = snapshot.data;
                return ListView.builder(
                  itemCount: listaContatos.length,
                  itemBuilder: (context, index) {
                    final Contato contato = listaContatos[index];

                    return Dismissible(
                      key: Key(contato.toString()),
                      onDismissed: (direction) {
                        setState(() {
                          listaContatos.removeAt(index);
                          _dao.excluir(contato.id);
                        });
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Contato excluído!")));
                      },
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment(-0.9, 0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      child: _ContatoItem(contato),
                    );
                  },
                );
                break;
            }
            //em caso de erro no switch acima
            return Text('Ocorreu um erro, tente novamente.');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContatoForm(),
            ),
          );
          //quando quero pegar informação do formulário e imprimir
          //.then(
          //  (novoContato) => debugPrint(novoContato.toString()),
          //);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContatoItem extends StatelessWidget {
  final Contato contato;

  _ContatoItem(this.contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn4.iconfinder.com/data/icons/avatar-circle-1-1/72/91-512.png'),
            ),
            title: Text(
              contato.nome,
              style: TextStyle(fontSize: 24.0),
            ),
            subtitle: Text(
              contato.numeroConta.toString(),
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
