import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import '../../http/web_clients/i18n_webclient.dart';
import 'i18n_messages.dart';
import 'i18n_state.dart';

class I18nMessagesCubit extends Cubit<I18nMessagesStare> {
  final String _viewKey;
  final LocalStorage _storage = LocalStorage('local_insecure_version_1.json');

  I18nMessagesCubit(this._viewKey) : super(const InitI18nMessagesState());

  void reload(I18nWebClient client) async {
    emit(
      const LoadingI18nMessagesState(),
    );
    await _storage.ready;
    final items = _storage.getItem(_viewKey);

//    print('Loaded $items');

    if (items != null) {
      emit(LoadedI18nMessagesState(I18nMessages(items)));
      return;
    }
    Map<String, dynamic> messages = await client.findAll();
    saveAndRefresh(messages);
  }

  saveAndRefresh(Map<String, dynamic> messages) {
    _storage.setItem(_viewKey, messages);
    final state = LoadedI18nMessagesState(I18nMessages(messages));
    emit(state);
  }
}
