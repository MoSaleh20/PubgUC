import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/main.dart';
import 'package:plant_app/constants.dart';
import 'package:toast/toast.dart';
import '../../constants.dart';
import '../../databaseProvider.dart';
import 'components/body.dart';

// ignore: must_be_immutable
class MoreScreen extends StatefulWidget {
  String title;
  MoreScreen(this.title);

  @override
  _MoreScreenState createState() => _MoreScreenState(title);
}

class _MoreScreenState extends State<MoreScreen> {
  _MoreScreenState(this.title);
  String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: moreAppBar(size.width, context, widget.title),
      body: Body(),
    );
  }

  AppBar moreAppBar(size, context, title) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      toolbarHeight: 80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(60),
        ),
      ),
      leadingWidth: size * 0.3,
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ));
        },
      ),
      actions: <Widget>[
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                _showDialog(context);
              },
            ),
            SizedBox(
              width: size * 0.1,
            )
          ],
        )
      ],
    );
  }

  void _showDialog(BuildContext context) {
    List<PubgUc> ucPacks;
    int id;
    if (uc.isNotEmpty) id = uc.last.id + 1;

    TextEditingController valueController = TextEditingController();
    TextEditingController costController = TextEditingController();
    contentBox(context) {
      return FutureBuilder(
          future: DatabaseProvider.db.packs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ucPacks = snapshot.data;
              uc = ucPacks;
            }
            return SingleChildScrollView(
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
                      borderRadius: BorderRadius.circular(kDefaultPadding),
                      boxShadow: [
                        BoxShadow(
                            color: kPrimaryColor,
                            offset: Offset(0, 10),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Add a new UC pack",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                          controller: valueController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                              icon: Icon(Icons.label), hintText: "Value")),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                          controller: costController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"^\d*\.?\d*"))
                          ],
                          decoration: InputDecoration(
                              icon: Icon(Icons.money_off_csred_outlined),
                              hintText: "Cost")),
                      SizedBox(
                        height: 22,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                            onPressed: () {
                              bool unique = true;
                              for (var i = 0; i < ucPacks.length; i++) {
                                if (ucPacks[i].name ==
                                    "PUBG UC ${valueController.text}")
                                  unique = false;
                              }
                              if (valueController.text.isNotEmpty &&
                                  costController.text.isNotEmpty &&
                                  unique) {
                                DatabaseProvider.db.insertPack(PubgUc(
                                  id: id,
                                  name: "PUBG UC ${valueController.text}",
                                  cost: double.parse(costController.text),
                                  count: 0,
                                ));
                                Navigator.of(context).pop();
                                Toast.show('UC pack added!', context,
                                    backgroundColor: Colors.green);
                                setState(() {});
                              } else if (valueController.text.isEmpty ||
                                  costController.text.isEmpty) {
                                Toast.show('Fill all fields!', context);
                              } else if (!unique) {
                                Toast.show('Pack is already added!', context);
                              }
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  child: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 30,
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(kDefaultPadding)),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 50,
                        )),
                  ),
                ),
              ],
            ));
          });
    }

    showDialog(
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding),
            ),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            child: contentBox(context),
          );
        },
        context: context);
  }
}
