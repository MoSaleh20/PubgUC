import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';

// ignore: must_be_immutable
class Invoices extends StatefulWidget {
  Customer customer;
  List<PubgUc> invoices;
  @override
  _InvoicesState createState() => _InvoicesState(customer, invoices);
  Invoices(this.customer, this.invoices);
}

class _InvoicesState extends State<Invoices> {
  Customer customer;
  List<PubgUc> invoices;
  _InvoicesState(this.customer, this.invoices);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        if (invoices.isEmpty) {
          return Text('no invoices');
        } else {
          DateTime now = DateTime.parse(invoices[index].date);

          return Container(
            child: ListTile(
              focusColor: Colors.white,
              title: Text(invoices[index].name),
              subtitle: Text('${invoices[index].price}'),
              trailing: Text(
                  '${now.year}-${now.month}-${now.day}  ${now.hour}:${now.minute}'),
            ),
          );
        }
      },
    );
  }
}
