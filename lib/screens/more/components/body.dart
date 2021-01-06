import 'package:flutter/material.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:focused_menu/modals.dart';
import 'package:plant_app/screens/details/details_screen.dart';
import 'package:plant_app/size_config.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<PubgUc> ucPacks;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
              future: DatabaseProvider.db.packs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ucPacks = snapshot.data;
                  uc = ucPacks;

                  return SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              ...List.generate(
                                ucPacks.length,
                                (index) => FocusedMenuHolder(
                                    menuBoxDecoration: BoxDecoration(
                                        color: Colors.transparent),
                                    animateMenuItems: false,
                                    duration: Duration(milliseconds: 1),
                                    menuWidth: size.width * 0.5,
                                    menuItems: <FocusedMenuItem>[
                                      FocusedMenuItem(
                                        title: Text(
                                          "Edit",
                                        ),
                                        trailingIcon: Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                      FocusedMenuItem(
                                        title: Text(
                                          "Favorite",
                                        ),
                                        trailingIcon:
                                            isFavoriteIcon(ucPacks[index]),
                                        onPressed: () {
                                          PubgUc thisUcPack = ucPacks[index];
                                          if (thisUcPack.isFavorite == 1)
                                            thisUcPack.isFavorite = 0;
                                          else
                                            thisUcPack.isFavorite = 1;
                                          setState(() {});
                                          DatabaseProvider.db
                                              .updatePack(thisUcPack);
                                          Toast.show(
                                              "Added to favorite!", context);
                                        },
                                      ),
                                      FocusedMenuItem(
                                        backgroundColor: Colors.redAccent,
                                        title: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        trailingIcon: Icon(
                                          Icons.delete_sweep,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kDefaultPadding),
                                                ),
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.red[600],
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: kDefaultPadding,
                                                          top: 20 +
                                                              kDefaultPadding,
                                                          right:
                                                              kDefaultPadding,
                                                          bottom:
                                                              kDefaultPadding),
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  kDefaultPadding),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                offset: Offset(
                                                                    0, 10),
                                                                blurRadius: 10),
                                                          ]),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 160,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Deletion can't be undone.",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          // DatabaseProvider
                                                                          //     .db
                                                                          //     .removePack(ucPacks[index].name);
                                                                          Toast.show(
                                                                              'This Pack cannot be deleted!',
                                                                              context,
                                                                              backgroundColor: Colors.red[600],
                                                                              duration: 5);
                                                                          Navigator.of(context)
                                                                              .pop();

                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Delete",
                                                                          style: TextStyle(
                                                                              color: Colors.red[600],
                                                                              fontSize: 18),
                                                                        )),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: kDefaultPadding,
                                                      right: kDefaultPadding,
                                                      top: kDefaultPadding,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 100,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        kDefaultPadding)),
                                                            child: Image.asset(
                                                              'assets/images/deleteGIF.gif',
                                                              scale: 1,
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            context: context,
                                          );
                                        },
                                      ),
                                    ],
                                    onPressed: () {},
                                    child: UCcards(
                                      image: ucPacks[index].image,
                                      title: ucPacks[index].name,
                                      price: ucPacks[index].cost,
                                      icon: isFavoriteIcon(ucPacks[index]),
                                      press: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                      ucPacks[index].name),
                                            ));
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else
                  return Text('no data');
              }),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }

  Icon isFavoriteIcon(PubgUc ucPack) {
    if (ucPack.isFavorite != 1) {
      return Icon(Icons.favorite_border);
    } else
      return Icon(Icons.favorite);
  }
}
