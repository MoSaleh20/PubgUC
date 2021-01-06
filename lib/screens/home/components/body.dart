import 'package:flutter/material.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:plant_app/screens/more/more_screen.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<PubgUc> ucPacks;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: DatabaseProvider.db.packs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ucPacks = snapshot.data;
            uc = ucPacks;
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeaderWithSearchBox(size: size),
                TitleWithMoreBtn(
                    text: "More",
                    title: "UC Packs",
                    press: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoreScreen("UC Packs"),
                          ));
                    }),
                RecomendsPlants(),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          );
        });
  }
}
