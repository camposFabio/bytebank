import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista_transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String _titulo = 'Últmas transferências';

class UltimasTransferencias extends StatelessWidget {
  const UltimasTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        _titulo,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      Consumer<Transferencias>(
        builder: (context, transferencias, child) {
          final _ultimasTransferencias =
              transferencias.transferencias.reversed.toList();
          final int _quantidade = transferencias.transferencias.length;
          int tamanho = 2;

          if (_quantidade == 0) {
            return const SemTransferenciaCadastrada();
          }

          if (_quantidade < 2) {
            tamanho = _quantidade;
          }
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tamanho,
              shrinkWrap: true,
              itemBuilder: (contex, index) {
                return ItemTransferencia(
                    transferencia: _ultimasTransferencias[index]);
              });
        },
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          child: const Text('Ver Todas'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const ListaTransferencias();
                },
              ),
            );
          },
        ),
      ),
    ]);
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  const SemTransferenciaCadastrada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text('Você não cadastrou nenhuma transferência'),
      ),
    );
  }
}
