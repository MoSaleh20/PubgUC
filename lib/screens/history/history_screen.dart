import 'package:flutter/material.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/drawer/drawer_screen.dart';

import '../../constants.dart';
import 'components/body.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: historyAppBar("History", size.width),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
