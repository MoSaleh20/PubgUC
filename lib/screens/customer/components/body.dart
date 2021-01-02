import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/customer/components/invoices.dart';

import 'header.dart';

class Body extends StatelessWidget {
  Customer customer;
  Body(this.customer);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<PubgUc> invoices = [];
    if (allInvoices.isNotEmpty)
      for (var i = 0; i < allInvoices.length; i++) {
        if (allInvoices[i].customerID == customer.id) {
          invoices.add(allInvoices[i]);
        }
      }
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Header(
        size: size,
        customer: customer,
      ),
      Invoices(customer, invoices),
    ]));
  }
}
