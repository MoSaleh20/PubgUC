import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/screens/details/details_screen.dart';
import 'package:plant_app/screens/history/history_screen.dart';
import 'package:plant_app/screens/home/home_screen.dart';

import '../constants.dart';
import '../main.dart';

class MyBottomNavBar extends StatefulWidget {
  MyBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
      ),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 20,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              homeIcon(),
              size: 35,
            ),
            onPressed: () {
              home = true;
              history = false;
              profile = false;
              main();
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(
              historyIcon(),
              size: 35,
            ),
            onPressed: () {
              home = false;
              history = true;
              profile = false;
              main();
            },
          ),
          IconButton(
            icon: Icon(
              profileIcon(),
              size: 35,
            ),
            onPressed: () {
              home = false;
              history = false;
              profile = true;
              main();
            },
          ),
        ],
      ),
    );
  }

  IconData homeIcon() {
    if (home) {
      return Icons.add_to_photos_rounded;
    } else {
      return Icons.add_to_photos_outlined;
    }
  }

  IconData historyIcon() {
    if (history) {
      return Icons.assignment_turned_in_rounded;
    } else {
      return Icons.assignment_turned_in_outlined;
    }
  }

  IconData profileIcon() {
    if (profile) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }
}
