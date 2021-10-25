import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../http/web_clients/i18n_webclient.dart';
import '../bloc_container.dart';
import 'i18n_cubit.dart';
import 'i18n_loadingview.dart';

class I18nLoadingContainer extends BlocContainer {
  final I18nWidgetCreator _creator;
  final String _viewKey;
  final String _locale;

  const I18nLoadingContainer(
      {Key? key,
      required String viewKey,
      required String locale,
      required I18nWidgetCreator creator})
      : _creator = creator,
        _locale = locale,
        _viewKey = viewKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18nMessagesCubit>(
      create: (BuildContext context) {
        final I18nMessagesCubit cubit = I18nMessagesCubit(_viewKey);
        cubit.reload(I18nWebClient(viewKey: _viewKey, locale: _locale));
        return cubit;
      },
      child: I18nLoadingView(_creator),
    );
  }
}
