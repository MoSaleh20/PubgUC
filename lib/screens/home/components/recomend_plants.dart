import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:plant_app/screens/details/details_screen.dart';

import '../../../constants.dart';

class RecomendsPlants extends StatelessWidget {
  const RecomendsPlants({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PubgUc> ucPacks;
    if (uc.isNotEmpty) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
              future: DatabaseProvider.db.packs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ucPacks = snapshot.data;
                  uc = ucPacks;
                  List<PubgUc> onlyFavoriteUc = [];
                  for (var i = 0; i < ucPacks.length; i++) {
                    if (ucPacks[i].isFavorite == 1) {
                      onlyFavoriteUc.add(ucPacks[i]);
                    }
                  }
                  return Row(
                    children: <Widget>[
                      ...List.generate(
                        onlyFavoriteUc.length,
                        (index) => RecomendPlantCard(
                          image: onlyFavoriteUc[index].image,
                          title: onlyFavoriteUc[index].name,
                          price: onlyFavoriteUc[index].cost,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(onlyFavoriteUc[index].name),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  );
                } else
                  return Container(
                      padding: EdgeInsets.all(10), child: Text('Loading...'));
              }));
    } else
      return Container(
        padding: EdgeInsets.all(10),
        child: Text(
          'no data',
          style: GoogleFonts.aBeeZee(fontSize: 30),
        ),
      );
  }
}
