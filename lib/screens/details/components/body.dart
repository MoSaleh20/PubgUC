import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:plant_app/screens/item%20history/itemHistory_screen.dart';
import 'dialog.dart';
import 'image_and_icons.dart';
import 'title_and_price.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  Body(this.name);
  String name;

  @override
  _BodyState createState() => _BodyState(name);
}

class _BodyState extends State<Body> {
  _BodyState(this.name);
  List<Customer> custs;
  List<PubgUc> ucPacks;
  List<String> items = [];
  String dropDownValue;
  TextEditingController price = TextEditingController();

  String name;
  PubgUc pubg;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: FutureBuilder(
          future: DatabaseProvider.db.packs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ucPacks = snapshot.data;
              uc = ucPacks;
              for (var i = 0; i < ucPacks.length; i++) {
                if (name == ucPacks[i].name) {
                  pubg = ucPacks[i];
                }
              }

              return Container(
                  width: size.width,
                  height: size.height * 1.15,
                  child: Column(
                    children: <Widget>[
                      ImageAndIcons(
                        size: size * 0.72,
                        image: pubg.image,
                      ),
                      TitleAndPrice(title: pubg.name, price: pubg.cost),
                      SizedBox(height: kDefaultPadding / 2),
                      Column(children: [
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: size.width / 2,
                              height: 70,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                ),
                                color: kPrimaryColor,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return showOrderDialog(pubg, context);
                                      });
                                },
                                child: Text(
                                  "Add Order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: size.width / 2,
                              height: 70,
                              child: FlatButton(
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      bottomLeft: Radius.circular(40)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ItemHistoryScreen(pubg.name),
                                      ));
                                },
                                child: Text(
                                  "View History",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: size.width / 2,
                              height: 70,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                ),
                                color: Colors.redAccent[400],
                                onPressed: () {
                                  showDialog(
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              kDefaultPadding),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.red[600],
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: kDefaultPadding,
                                                  top: 20 + kDefaultPadding,
                                                  right: kDefaultPadding,
                                                  bottom: kDefaultPadding),
                                              margin: EdgeInsets.only(top: 20),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kDefaultPadding),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black,
                                                        offset: Offset(0, 10),
                                                        blurRadius: 10),
                                                  ]),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
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
                                                                  .grey[600],
                                                              fontSize: 11),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: FlatButton(
                                                            onPressed: () {
                                                              // DatabaseProvider
                                                              //     .db
                                                              //     .removePack(ucPacks[index].name);
                                                              Toast.show(
                                                                  'This Pack cannot be deleted!',
                                                                  context,
                                                                  backgroundColor:
                                                                      Colors.red[
                                                                          600],
                                                                  duration: 5);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();

                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red[600],
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
                                                backgroundColor: Colors.white,
                                                radius: 100,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
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
                                child: Text(
                                  "Delete Pack",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ));
            } else
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Data not available!'));
          }),
    );
  }
}
