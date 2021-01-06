import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/screens/customer/components/invoices.dart';
import 'package:plant_app/databaseProvider.dart';
import 'header.dart';

class Body extends StatelessWidget {
  Customer customer;
  Body(this.customer);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double dept = 0;
    List<PubgUc> thisCustInvoices = [];
    List<PubgUc> invoices = [];
    return SingleChildScrollView(
      child: FutureBuilder(
        future: DatabaseProvider.db.orders,
        builder: (context, snapshot) {
          invoices = snapshot.data;
          if (snapshot.hasData) {
            for (var i = 0; i < invoices.length; i++) {
              if (invoices[i].customerName == customer.name) {
                thisCustInvoices.add(invoices[i]);
                dept += invoices[i].price;
              }
            }
            customer.dept = dept;
            return SingleChildScrollView(
                child: Column(children: <Widget>[
              Header(
                size: size,
                customer: customer,
              ),
              Invoices(customer, thisCustInvoices),
            ]));
          } else
            return Container(
                child: Text('No data!'), padding: EdgeInsets.all(10));
        },
      ),
    );
  }
}
