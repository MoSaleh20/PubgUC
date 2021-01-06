import 'package:meta/meta.dart';
import 'dart:convert';

Customer customerFromMap(String str) => Customer.fromMap(json.decode(str));

String customerToMap(Customer data) => json.encode(data.toMap());

class Customer {
  Customer({
    @required this.id,
    @required this.name,
    this.dept,
    this.inDept,
    this.date,
    this.payment,
    this.phone,
  }) {
    if (this.dept == this.payment)
      this.inDept == 0;
    else
      this.inDept == 1;
  }

  int id;
  String name;
  double dept = 0;
  int inDept = 0;
  String date;
  double payment = 0;
  String phone;

  factory Customer.fromMap(Map<String, dynamic> data) {
    return Customer(
      id: data['id'],
      name: data['name'],
      dept: data['dept'],
      inDept: data['inDept'],
      date: data['date'],
      payment: data['payment'],
      phone: data['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'dept': this.dept,
      'inDept': this.inDept,
      'date': this.date,
      'payment': this.payment,
      'phone': this.phone,
    };
  }
}
