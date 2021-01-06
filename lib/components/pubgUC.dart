import 'package:meta/meta.dart';
import 'dart:convert';

PubgUc pubgUcFromMap(String str) => PubgUc.fromMap(json.decode(str));

String pubgUcToMap(PubgUc data) => json.encode(data.toMap());

class PubgUc {
  PubgUc({
    @required this.id,
    @required this.name,
    @required this.cost,
    this.invoiceID,
    this.price,
    this.image,
    this.date,
    this.customerName,
    this.count,
    this.profit,
    this.isFavorite,
  }) {
    this.image = "assets/images/Pubg UC 60.png";
  }

  int id;
  String name;
  double cost;
  double price;
  String image;
  String date;
  int invoiceID;
  String customerName;
  int count;
  double profit;
  int isFavorite = 0;

  factory PubgUc.fromMap(Map<String, dynamic> data) {
    return PubgUc(
      id: data['id'],
      name: data['name'],
      cost: data['cost'],
      price: data['price'],
      image: data['image'],
      date: data['date'],
      invoiceID: data['invoiceID'],
      customerName: data['customerName'],
      count: data['count'],
      profit: data['profit'],
      isFavorite: data['isFavorite'],
    );
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
      'customerName': this.customerName,
      'count': this.count,
      'profit': this.profit,
      'isFavorite': this.isFavorite,
    };
  }
}
