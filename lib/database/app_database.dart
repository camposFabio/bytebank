import 'package:bytebank/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _tableName = 'contacts';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE $_tableName('
            'id INTEGER PRIMARY KEY, '
            'name TEXT, '
            'account_number INTEGER)');
      },
      version: 1,
      //onDowngrade: onDatabaseDowngradeDelete,
    );
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert(_tableName, contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query(_tableName).then((maps) {
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
            id: map['id'],
            name: map['name'],
            accountNumber: map['account_number']);
        contacts.add(contact);
      }
      return contacts;
    });
  });
}
