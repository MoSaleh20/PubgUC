import 'package:flutter/material.dart';
import 'package:plant_app/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen(this.id);
  int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id),
    );
  }
}
