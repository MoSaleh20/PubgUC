import 'package:flutter/material.dart';
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
            icon: historyIcon(),
            onPressed: () {
              home = false;
              history = true;
              profile = false;
              main();
            },
          ),
          IconButton(
            icon: homeIcon(),
            onPressed: () {
              home = true;
              history = false;
              profile = false;
              main();
              setState(() {});
            },
          ),
          IconButton(
            icon: profileIcon(),
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

  Icon homeIcon() {
    if (home) {
      return Icon(
        Icons.add_to_photos,
        size: 30,
        color: Colors.blue[600],
      );
    } else {
      return Icon(
        Icons.add_to_photos_outlined,
        size: 25,
      );
    }
  }

  Icon historyIcon() {
    if (history) {
      return Icon(
        Icons.assignment_turned_in_rounded,
        size: 30,
        color: Colors.green[500],
      );
    } else {
      return Icon(
        Icons.assignment_turned_in_outlined,
        size: 25,
      );
    }
  }

  Icon profileIcon() {
    if (profile) {
      return Icon(
        Icons.favorite,
        size: 30,
        color: Colors.redAccent[400],
      );
    } else {
      return Icon(
        Icons.favorite_border,
        size: 25,
      );
    }
  }
}
