import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../database/dao/contact_dao.dart';
import 'contacts_list_cubit.dart';
import 'contacts_list_view.dart';

class ContactsListContainer extends BlocContainer {
  const ContactsListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactDao dao = ContactDao();

    return BlocProvider<ContactsListCubit>(
        create: (context) {
          final ContactsListCubit cubit = ContactsListCubit();
          cubit.reload(dao);
          return cubit;
        },
        child: ContactsListView(
          dao: dao,
        ));
  }
}
