import 'package:meta/meta.dart';
import 'dart:convert';

Customer customerFromMap(String str) => Customer.fromMap(json.decode(str));

String customerToMap(Customer data) => json.encode(data.toMap());

class Customer {
  Customer(
      {@required this.id,
      @required this.name,
      this.dept,
      this.inDept,
      this.date,
      this.payment}) {
    if (dept != 0 && dept != null) {
      inDept = true;
    } else
      inDept = false;
  }

  int id;
  String name;
  double dept;
  bool inDept = false;
  String date;
  double payment;

  factory Customer.fromMap(Map<String, dynamic> data) {
    return Customer(
        id: data['id'],
        name: data['name'],
        dept: data['dept'],
        inDept: data['inDept'],
        date: data['date'],
        payment: data['payment']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'dept': this.dept,
      'inDept': this.inDept,
      'date': this.date,
      'payment': this.payment
    };
  }
}
