import 'package:bytebank/components/components.dart';
import 'package:bytebank/screens/deposito/formulario_deposito.dart';
import 'package:bytebank/screens/transferencia/formulario_transferencia.dart';
import 'package:bytebank/screens/transferencia/ultimas_transferencias.dart';
import 'package:flutter/material.dart';

class Dasboard extends StatelessWidget {
  const Dasboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ByteBank'),
      ),
      body: ListView(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text('Receber depósito'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FormularioDeposito();
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text('Nova Transferência'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FormularioTransferencia();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          const UltimasTransferencias(),
        ],
      ),
    );
  }
}
