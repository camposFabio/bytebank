import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/models.dart';
import 'package:bytebank/screens/screens.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: FutureBuilder<List<Contact>>(
          initialData: const [],
          future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Loading...'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Contact> contacts = snapshot.data ?? [];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Contact contact = contacts[index];
                      return _ContactItem(contact: contact);
                    },
                    itemCount: contacts.length,
                  );
                }
                break;
            }
            return Text('Unknow Error');
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => ContactForm(),
              ),
            )
                .then((value) {
              setState(() {});
            });
          },
          child: Icon(Icons.add),
        ));
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
