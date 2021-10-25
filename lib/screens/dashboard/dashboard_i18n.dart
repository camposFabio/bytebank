import '../../components/localization/i18n_messages.dart';

class DashboardViewLazyi18n {
  final I18nMessages _messages;

  DashboardViewLazyi18n(this._messages);

  String get welcome => _messages.get('welcome');

  String get transfer => _messages.get('transfer');

  String get transactionFeed => _messages.get('transactionFeed');

  String get changeName => _messages.get('changeName');
}
