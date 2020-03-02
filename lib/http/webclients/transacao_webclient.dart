import 'dart:convert';

import 'package:bytebank_persistencia/models/transacao.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransacaoWebClient {
  Future<List<Transacao>> findAll() async {
    final Response response = await client.get(baseUrl);

    if (response.statusCode == 200) {
      final List<dynamic> decodeJson = jsonDecode(response.body);
      return decodeJson
          .map((dynamic json) => Transacao.fromJson(json))
          .toList();
    }

    _throwHttpError(response.statusCode);

  }

  Future<Transacao> save(Transacao transacao, String password) async {
    final String transacaoJson = jsonEncode(transacao.toJson());

    final Response response = await client.post(
        baseUrl,
        headers: {'Content-type': 'application/json', 'password': password},
        body: transacaoJson);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Transacao.fromJson(jsonDecode(response.body));
    }

    _throwHttpError(response.statusCode);
  }

  void _throwHttpError(int statusCode) => throw Exception(_statusCodeResponses[statusCode]);

  static final Map<int, String> _statusCodeResponses = {
    400: 'Ocorreu algum erro na transferência',
    401: 'Erro na autenticação',
  };
}
