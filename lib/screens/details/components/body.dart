import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import '../../../databaseProvider.dart';
import 'image_and_icons.dart';
import 'title_and_price.dart';

class Body extends StatefulWidget {
  Body(this.id);
  int id;

  @override
  _BodyState createState() => _BodyState(id);
}

class _BodyState extends State<Body> {
  List<Customer> custs;

  List<String> items = ["unknown"];
  String defaultValue = "unknown";
  String dropDownValue;
  var dateTimeGenerator = new DateTime.now();
  List<String> customers = [];

  TextEditingController price = TextEditingController();
  _BodyState(this.id);
  int id;
  @override
  Widget build(BuildContext context) {
    String now =
        "${dateTimeGenerator.year}-${dateTimeGenerator.month}-${dateTimeGenerator.day}  ${dateTimeGenerator.hour}:${dateTimeGenerator.minute}";
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(
            size: size,
            image: uc[widget.id].image,
          ),
          TitleAndPrice(title: uc[widget.id].name, price: uc[widget.id].cost),
          SizedBox(height: kDefaultPadding / 3.5),
          Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 70,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {
                    showDialog(
                        builder: (context) {
                          return FutureBuilder(
                              future: DatabaseProvider.db.custs,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  custs = snapshot.data;
                                  allCustomers = custs;
                                  for (var i = 0; i < custs.length; i++) {
                                    customers = ["unknown"];
                                    customers.add(custs[i].name);
                                    print(custs[i].name);
                                  }
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          kDefaultPadding),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.black,
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
                                                height: 15,
                                              ),
                                              Text(
                                                uc[widget.id].name,
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                now,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextField(
                                                  controller: price,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r"^\d*\.?\d*"))
                                                  ],
                                                  decoration: InputDecoration(
                                                      icon: Icon(Icons
                                                          .money_rounded))),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              DropdownButton<String>(
                                                value: defaultValue,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                dropdownColor: Colors.white,
                                                items: items.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      "$value",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    defaultValue = newValue;
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: FlatButton(
                                                    onPressed: () {
                                                      if (allCustomers
                                                          .isNotEmpty)
                                                        for (var i = 0;
                                                            i <
                                                                allCustomers
                                                                    .length;
                                                            i++) {
                                                          if (allCustomers[i]
                                                                  .name ==
                                                              defaultValue) {
                                                            uc[widget.id]
                                                                    .customerID =
                                                                allCustomers[i]
                                                                    .id;
                                                          }
                                                        }
                                                      if (price.text
                                                              .isNotEmpty &&
                                                          dropDownValue !=
                                                              null) {
                                                        DatabaseProvider.db
                                                            .insertInvoice(
                                                                PubgUc(
                                                          id: uc[widget.id].id,
                                                          name: uc[widget.id]
                                                              .name,
                                                          cost: uc[widget.id]
                                                              .cost,
                                                          customerID:
                                                              uc[widget.id]
                                                                  .customerID,
                                                          price: double.parse(
                                                              price.text),
                                                          image: uc[widget.id]
                                                              .image,
                                                          date: now,
                                                        ));
                                                        Navigator.of(context)
                                                            .pop();
                                                        price.text = "";
                                                        Toast.show(
                                                            'Invoice Added!',
                                                            context);
                                                      } else {
                                                        Toast.show(
                                                            'Insert a price!',
                                                            context);
                                                      }
                                                    },
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: kDefaultPadding,
                                          right: kDefaultPadding,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 30,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        kDefaultPadding)),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 50,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else
                                  return Text('NO DATA!!');
                              });
                        },
                        context: context);
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
              Expanded(
                child: SizedBox(
                  width: size.width / 2,
                  height: 70,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "View History",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
//  void __showDialog(BuildContext context) {

//     List<String> items = ["a", "b"];
//     String defaultValue = "a";
//     var dateTimeGenerator = new DateTime.now();
//     String now =
//         "${dateTimeGenerator.year}-${dateTimeGenerator.month}-${dateTimeGenerator.day}  ${dateTimeGenerator.hour}:${dateTimeGenerator.minute}";
//     TextEditingController price = TextEditingController();
//     contentBox(context) {
//       return Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(
//                 left: kDefaultPadding,
//                 top: 20 + kDefaultPadding,
//                 right: kDefaultPadding,
//                 bottom: kDefaultPadding),
//             margin: EdgeInsets.only(top: 20),
//             decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(kDefaultPadding),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black,
//                       offset: Offset(0, 10),
//                       blurRadius: 10),
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   uc[widget.id].name,
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   now,
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextField(
//                     controller: price,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*"))
//                     ],
//                     decoration:
//                         InputDecoration(icon: Icon(Icons.money_rounded))),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 DropdownButton<String>(
//                   dropdownColor: Colors.black,
//                   items: items.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: defaultValue,
//                       child: Text(
//                         "$value",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (_) {},
//                 ),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: FlatButton(
//                       onPressed: () {
//                         if (price.text.isNotEmpty) {
//                           DatabaseProvider.db.insertInvoice(PubgUc(
//                             id: uc[widget.id].id,
//                             name: uc[widget.id].name,
//                             cost: uc[widget.id].cost,
//                             price: double.parse(price.text),
//                             image: uc[widget.id].image,
//                             date: now,
//                           ));
//                           Navigator.of(context).pop();
//                           Toast.show('Invoice Added!', context);
//                         } else {
//                           Toast.show('Insert a price!', context);
//                         }
//                       },
//                       child: Text(
//                         "Add",
//                         style: TextStyle(fontSize: 18),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             left: kDefaultPadding,
//             right: kDefaultPadding,
//             child: CircleAvatar(
//               backgroundColor: Colors.black,
//               radius: 30,
//               child: ClipRRect(
//                   borderRadius:
//                       BorderRadius.all(Radius.circular(kDefaultPadding)),
//                   child: Icon(
//                     Icons.add,
//                     color: Colors.white,
//                     size: 50,
//                   )),
//             ),
//           ),
//         ],
//       );
//     }

// //     showDialog(
// //         builder: (context) {
// //           return Dialog(
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(kDefaultPadding),
// //             ),
// //             elevation: 0,
// //             backgroundColor: Colors.black,
// //             child: contentBox(context),
// //           );
// //         },
// //         context: context);
// //   }
// // }

//   }
}
