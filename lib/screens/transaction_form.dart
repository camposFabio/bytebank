import 'dart:async';

import 'package:bytebank/components/components.dart';
import 'package:bytebank/http/web_clients/transaction_web_cliente.dart';
import 'package:bytebank/models/models.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm({Key? key, required this.contact}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = const Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Sending...',
                  ),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(
                          id: transactionId,
                          value: value,
                          contact: widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              },
                            );
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

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    final Transaction? transaction = await _send(
        transactionCreated: transactionCreated,
        password: password,
        context: context);

    _showSuccessfulMessage(transaction, context);
  }

  Future<void> _showSuccessfulMessage(
      Transaction? transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return const SuccessDialog(message: 'sucessfull transaction');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction?> _send(
      {required Transaction transactionCreated,
      required String password,
      required BuildContext context}) async {
    setState(() {
      _sending = true;
    });
    try {
      return await _webClient.save(
          transaction: transactionCreated, password: password);
    } on HttpException catch (e) {
      _showFailureMessage(context, message: e.message ?? '');
    } on TimeoutException {
      _showFailureMessage(context,
          message: 'timeout submitting the transaction');
    } catch (e) {
      _showFailureMessage(context);
    } finally {
      setState(() {
        _sending = false;
      });
    }
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknow Error'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message: message);
        });
  }
}
