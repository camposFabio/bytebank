import 'package:bytebank/components/components.dart';
import 'package:bytebank/http/web_clients/transaction_web_cliente.dart';
import 'package:bytebank/models/models.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TransactionWebClient _webClient = TransactionWebClient();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: _webClient.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const Progress();

              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction> transactions = snapshot.data ?? [];

                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                }

                return const CenteredMessage(
                  message: 'No transactions found',
                  icon: Icons.warning,
                );
              default:
                return const CenteredMessage(message: 'Unknow Error');
            }
          },
        ));
  }
}
