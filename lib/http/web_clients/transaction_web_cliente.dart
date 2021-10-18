import 'dart:convert';
import 'package:bytebank/http/web_client.dart';
import 'package:bytebank/models/models.dart';
import 'package:http/http.dart';

const String baseUrl = 'http://192.168.31.110:8080/transactions';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    var url = Uri.parse(baseUrl);
    final Response response =
        await client.get(url).timeout(const Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction?> save({required Transaction transaction}) async {
    var url = Uri.parse(baseUrl);

    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(url,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
