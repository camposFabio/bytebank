import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../models/models.dart';
import '../contacts_list/contacts_list.dart';
import '../screens.dart';
import 'dashboard_feature_item.dart';
import 'dashboard_i18n.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewLazyi18n _i18n;

  const DashboardView(this._i18n, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // misturando um blockbuilder (que é um observador de eventos) com UI
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('${_i18n.welcome} $state'),
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/bytebank_logo.png'),
              ),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FeatureItem(
                      name: _i18n.transfer,
                      icon: Icons.monetization_on,
                      onClick: () => _showContactsList(context),
                    ),
                    FeatureItem(
                      name: _i18n.transactionFeed,
                      icon: Icons.description,
                      onClick: () => _showTransactionsList(context),
                    ),
                    FeatureItem(
                      name: _i18n.changeName,
                      icon: Icons.person_outline,
                      onClick: () => _showChangeName(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext blocContext) {
    push(blocContext, const ContactsListContainer());
  }

  void _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(blocContext),
          child: const NameContainer(),
        ),
      ),
    );
  }

  void _showTransactionsList(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) => const TransactionsList(),
      ),
    );
  }
}
