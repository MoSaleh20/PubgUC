import 'package:flutter/material.dart';
import 'package:plant_app/screens/details/components/body.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  DetailsScreen(this.name);
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(name),
    );
  }
}
