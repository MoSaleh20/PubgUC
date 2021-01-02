import 'package:flutter/material.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';

import '../../constants.dart';
import 'components/body.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
