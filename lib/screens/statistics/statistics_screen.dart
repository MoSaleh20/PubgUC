import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/body.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, "Statistics"),
      body: Body(),
    );
  }
}
