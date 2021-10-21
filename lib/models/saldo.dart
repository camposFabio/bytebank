import 'package:flutter/foundation.dart';

class Saldo extends ChangeNotifier {
  double valor;

  Saldo({this.valor = 0});

  void adiciona({required double valor}) {
    this.valor += valor;

    notifyListeners();
  }

  void subtrai({required double valor}) {
    this.valor -= valor;

    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $valor';
  }
}
