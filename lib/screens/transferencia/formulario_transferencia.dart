import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoNumeroConta,
                dica: _dicaCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta,
              ),
              Editor(
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: const Text(_textoBotaoConfirmar),
                onPressed: () => _criaTransferencia(context),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta =
        int.tryParse(_controladorCampoNumeroConta.text) ?? 0;
    final double valor = double.tryParse(_controladorCampoValor.text) ?? 0;
    final bool transferenciaValida =
        _validaTransferencia(context, numeroConta: numeroConta, valor: valor);

    if (transferenciaValida) {
      final novaTransferencia = Transferencia(valor, numeroConta);
      _atualizaEstado(context, transferencia: novaTransferencia, valor: valor);
      Navigator.pop(context);
    }
  }

  bool _validaTransferencia(BuildContext context,
      {required int numeroConta, required double valor}) {
    final _camposPreenchidos = (numeroConta > 0) && valor > 0;
    final _saldoSufuciente =
        valor <= Provider.of<Saldo>(context, listen: false).valor;
    return _camposPreenchidos && _saldoSufuciente;
  }

  void _atualizaEstado(BuildContext context,
      {required Transferencia transferencia, required double valor}) {
    Provider.of<Transferencias>(context, listen: false).adiciona(transferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor: valor);
  }
}
