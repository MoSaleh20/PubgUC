import 'package:meta/meta.dart';
import 'dart:convert';

PubgUc pubgUcFromMap(String str) => PubgUc.fromMap(json.decode(str));

String pubgUcToMap(PubgUc data) => json.encode(data.toMap());

class PubgUc {
  PubgUc(
      {@required this.id,
      @required this.name,
      @required this.cost,
      this.invoiceID,
      this.price,
      this.image,
      this.date,
      this.customerID}) {
    this.image = "assets/images/Pubg UC 60.png";
  }

  int id;
  String name;
  double cost;
  double price;
  String image;
  String date;
  int invoiceID;
  int customerID;

  factory PubgUc.fromMap(Map<String, dynamic> data) {
    return PubgUc(
        id: data['id'],
        name: data['name'],
        cost: data['cost'],
        price: data['price'],
        image: data['image'],
        date: data['date'],
        invoiceID: data['invoiceID'],
        customerID: data['customerID']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'cost': this.cost,
      'price': this.price,
      'image': this.image,
      'date': this.date,
      'invoiceID': this.invoiceID,
      'customerID': this.customerID
    };
  }
}
