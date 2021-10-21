import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/components/editor.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Receber depósito';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioDeposito extends StatelessWidget {
  FormularioDeposito({Key? key}) : super(key: key);
  final TextEditingController _controladorCampoValor = TextEditingController();

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
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: const Text(_textoBotaoConfirmar),
                onPressed: () => _criaDeposito(context),
              ),
            ],
          ),
        ));
  }

  void _criaDeposito(BuildContext context) {
    final double valor = double.tryParse(_controladorCampoValor.text) ?? 0;
    final depositoValido = _validaDeposito(valor: valor);

    if (depositoValido) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  _validaDeposito({required double valor}) {
    return valor > 0;
  }

  _atualizaEstado(BuildContext context, double valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor: valor);
  }
}
