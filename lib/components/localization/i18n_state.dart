import 'package:flutter/material.dart';

import 'i18n_messages.dart';

@immutable
class I18nMessagesStare {
  const I18nMessagesStare();
}

@immutable
class LoadingI18nMessagesState extends I18nMessagesStare {
  const LoadingI18nMessagesState();
}

@immutable
class InitI18nMessagesState extends I18nMessagesStare {
  const InitI18nMessagesState();
}

@immutable
class LoadedI18nMessagesState extends I18nMessagesStare {
  final I18nMessages messages;
  const LoadedI18nMessagesState(this.messages);
}

@immutable
class FatalErrorI18nMessagesState extends I18nMessagesStare {
  const FatalErrorI18nMessagesState();
}
