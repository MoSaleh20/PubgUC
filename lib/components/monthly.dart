import 'dart:convert';

monthly monthlyFromMap(String str) => monthly.fromMap(json.decode(str));

String monthlyToMap(monthly data) => json.encode(data.toMap());

class monthly {
  monthly({
    this.name,
    this.profit = 0.0,
  });

  String name;
  double profit;

  factory monthly.fromMap(Map<String, dynamic> data) {
    return monthly(name: data['name'], profit: data['profit']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'profit': this.profit,
    };
  }

  toString() {
    return "${this.name} - ${this.profit}///";
  }
}
