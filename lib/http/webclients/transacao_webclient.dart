import 'dart:convert';

import 'package:bytebank_persistencia/models/transacao.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransacaoWebClient {

  Future<List<Transacao>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    
    if (response.statusCode == 200) {
      final List<dynamic> decodeJson = jsonDecode(response.body);
      return decodeJson.map((dynamic json) => Transacao.fromJson(json)).toList();
    } else {
      print('OCORREU UM ERRO, TENTE NOVAMENTE.');
      throw Exception('OCORREU UM ERRO, TENTE NOVAMENTE.');
    }
  }

  Future<Transacao> save(Transacao transacao) async {
    final String transacaoJson = jsonEncode(transacao.toJson());

    final Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transacaoJson);

    return Transacao.fromJson(jsonDecode(response.body));
  }    

}
