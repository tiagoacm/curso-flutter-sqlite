import 'package:bytebank_persistencia/database/app_database.dart';
import 'package:bytebank_persistencia/models/contato.dart';
import 'package:sqflite/sqflite.dart';

class ContatoDao {
  static const String tblContatoSql =
      'CREATE TABLE $_nomeTabela(id INTEGER PRIMARY KEY , nome TEXT, numero_conta INTEGER)';
  static const String _nomeTabela = 'contatos';

  Future<List<Contato>> buscarTodos() async {
    final Database db = await getDatabase();
    final String _queryBuscar =
        'SELECT id, nome, numero_conta FROM $_nomeTabela ORDER BY nome ';
    //final List<Map<String, dynamic>> resultado = await db.query(_nomeTabela);
    final List<Map<String, dynamic>> resultado = await db.rawQuery(_queryBuscar);
    List<Contato> listaContatos = _toList(resultado);
    return listaContatos;
  }

  Future<int> salvar(Contato contato) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contatoMap = _toMap(contato);
    return db.insert(_nomeTabela, contatoMap);
  }

  Future<int> alterar(Contato contato) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contatoMap = _toMap(contato);
    return db.update(
      _nomeTabela,
      contatoMap,
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<void> excluir(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contatoMap = Map();
    //contatoMap['id'] = contato.id; SQLITE gera automatico
    contatoMap['nome'] = contato.nome;
    contatoMap['numero_conta'] = contato.numeroConta;
    return contatoMap;
  }

  List<Contato> _toList(List<Map<String, dynamic>> resultado) {
    final List<Contato> listaContatos = List();
    for (Map<String, dynamic> linha in resultado) {
      final Contato contato = Contato(
        linha['id'],
        linha['nome'],
        linha['numero_conta'],
      );
      listaContatos.add(contato);
    }
    return listaContatos;
  }
}
