import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../database/dao/contact_dao.dart';

import 'contacts_list_state.dart';

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(const InitContactsListState());

  void reload(ContactDao dao) async {
    emit(const LoadingContactsListState());
    List<Contact> contacts = await dao.findAll();
    emit(LoadedContactsListState(contacts));
  }
}
