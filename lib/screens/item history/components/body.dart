import 'package:flutter/material.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/databaseProvider.dart';

class Body extends StatefulWidget {
  String title;
  @override
  _BodyState createState() => _BodyState(title);
  Body(this.title);
}

class _BodyState extends State<Body> {
  _BodyState(this.title);
  String title;

  @override
  Widget build(BuildContext context) {
    List<PubgUc> invoices = [];
    List<PubgUc> itemInvoices = [];
    return SingleChildScrollView(
        child: Column(children: [
      FutureBuilder(
          future: DatabaseProvider.db.orders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              invoices = snapshot.data;
              allInvoices = invoices;
              for (var i = 0; i < invoices.length; i++) {
                if (invoices[i].name == title) itemInvoices.add(invoices[i]);
              }
              itemInvoices.sort((a, b) {
                return b.date
                    .toString()
                    .toLowerCase()
                    .compareTo(a.date.toString().toLowerCase());
              });
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: itemInvoices.length,
                itemBuilder: (context, index) {
                  DateTime now = DateTime.parse(invoices[index].date);
                  return Container(
                    child: ListTile(
                      focusColor: Colors.white,
                      subtitle: Text('${itemInvoices[index].price}'),
                      title: Text(itemInvoices[index].name),
                      trailing: Text(
                          "${now.year}-${now.month}-${now.day}  ${now.hour}:${now.minute}"),
                    ),
                  );
                },
              );
            } else
              return Text('No Data');
          })
    ]));
  }
}
