import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';

import 'components/body.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen(this.customer);
  Customer customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context),
      body: Body(customer),
    );
  }

  AppBar customerAppBar(context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
