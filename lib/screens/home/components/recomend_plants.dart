import 'package:flutter/material.dart';
import 'package:plant_app/screens/details/details_screen.dart';

import '../../../constants.dart';

class RecomendsPlants extends StatelessWidget {
  const RecomendsPlants({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          RecomendPlantCard(
            //0
            image: uc[0].image,
            title: uc[0].name,
            price: uc[0].cost,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(uc[0].id),
                ),
              );
            },
          ),
          RecomendPlantCard(
            //1
            image: uc[1].image,
            title: uc[1].name,
            price: uc[1].cost,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(uc[1].id),
                ),
              );
            },
          ),
          RecomendPlantCard(
            //2
            image: uc[2].image,
            title: uc[2].name,
            price: uc[2].cost,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(uc[2].id),
                ),
              );
            },
          ),
          RecomendPlantCard(
            //3
            image: uc[3].image,
            title: uc[3].name,
            price: uc[3].cost,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(uc[3].id),
                ),
              );
            },
          ),
          RecomendPlantCard(
            //4
            image: uc[4].image,
            title: uc[4].name,
            price: uc[4].cost,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(uc[4].id),
                ),
              );
            },
          ),
          RecomendPlantCard(
            //5
            image: uc[5].image,
            title: uc[5].name,
            price: uc[5].cost,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(uc[5].id),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
