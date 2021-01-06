import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/drawer/drawer_screen.dart';
import 'package:plant_app/screens/home/components/body.dart';
import 'package:plant_app/constants.dart';
//Todos:
//1.fix the problem with the database provider.done
//2.fix the null value in the customers screen...
//3.fix the alert icon in the customers screen and add it inside every customer's screen...
//4.in pubguc, change the data type from string to date.done
//5.in statistics, add more info like...(profit today, profit last month).done
//6.in statistics, fix the count value.done
//7.add images to all items of UC packs...
//8.add a drawer.done
//9.add favorite section...
//10.make the foucosd dialog buttons active...
//11.add splash screen...
//12.add statistics for customers...

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: mainAppBar(context),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar mainAppBar(context) {
    return AppBar(
      primary: true,
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset("assets/icons/menu.svg"),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.info,
            size: 30,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
