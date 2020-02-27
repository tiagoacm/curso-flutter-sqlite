import 'package:bytebank_persistencia/dao/contato_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {

  final String databaseName = 'bytebank.db';
  final int databaseVersao = 1;
  final String path = join(await  getDatabasesPath(), databaseName);
  return openDatabase(path, onCreate: (db, version) {
      db.execute(ContatoDao.tblContatoSql);
          
    }, version: databaseVersao,
      // limpa base de dados se regredir a versão do banco
      // onDowngrade: onDatabaseDowngradeDelete,  
    );
}

