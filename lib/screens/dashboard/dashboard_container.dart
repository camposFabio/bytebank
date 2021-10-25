import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../components/bloc_container.dart';
import '../../components/localization/i18n_container.dart';
import '../../components/localization/i18n_messages.dart';
import 'dashboard_view.dart';
import 'dashboard_i18n.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Fabio'),
      child: I18nLoadingContainer(
        viewKey: "dashboard",
        locale: "en",
        creator: (I18nMessages messages) =>
            DashboardView(DashboardViewLazyi18n(messages)),
      ),
    );
  }
}
