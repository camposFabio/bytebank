import 'package:bytebank/models/models.dart';

class Transaction {
  final double _value;
  final Contact _contact;

  Transaction({
    required double value,
    required Contact contact,
  })  : _value = value,
        _contact = contact;

  get value => _value;
  get contact => _contact;

  Transaction.fromJson(Map<String, dynamic> json)
      : _value = json['value'],
        _contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'value': _value,
        'contact': _contact.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{value: $_value, contact: $_contact}';
  }
}
