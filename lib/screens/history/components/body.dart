import 'package:flutter/material.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import '../../../databaseProvider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<PubgUc> invoices;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      FutureBuilder(
          future: DatabaseProvider.db.packs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              invoices = snapshot.data;
              allInvoices = invoices;
              invoices.sort((a, b) {
                return b.date
                    .toString()
                    .toLowerCase()
                    .compareTo(a.date.toString().toLowerCase());
              });
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ListTile(
                      focusColor: Colors.white,
                      subtitle: Text('${invoices[index].price}'),
                      title: Text(invoices[index].name),
                      trailing: Text('${invoices[index].date}'),
                    ),
                  );
                },
              );
            } else
              return Text('No Date');
          })
    ]));
  }
}
