import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/formulario_transferencia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: Consumer<Transferencias>(builder: (context, transferencias, child) {
        return ListView.builder(
          itemCount: transferencias.transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = transferencias.transferencias[indice];
            return ItemTransferencia(transferencia: transferencia);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia({Key? key, required Transferencia transferencia})
      : _transferencia = transferencia,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.toStringValor()),
      subtitle: Text(_transferencia.toStringConta()),
    ));
  }
}
