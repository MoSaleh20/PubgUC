import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/constants.dart';

import 'components/body.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen(this.customer);
  Customer customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, null),
      body: Body(customer),
    );
  }
}
