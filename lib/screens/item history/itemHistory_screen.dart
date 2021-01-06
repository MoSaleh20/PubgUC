import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/body.dart';

class ItemHistoryScreen extends StatelessWidget {
  String title;
  ItemHistoryScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, title),
      body: Body(title),
    );
  }
}
