import 'package:bytebank/components/localization/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Viewi18n {
  String _language = "en";

  Viewi18n(BuildContext context) {
    // O problema desta abordagem
    // é o rebuild quando trocar a lingua
    // o que vc quer reconstruir
    // em geral é comum reinicializar sistema
    _language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> values) {
    assert(values.containsKey(_language));
    return values[_language] ?? values["en"]!;
  }
}
