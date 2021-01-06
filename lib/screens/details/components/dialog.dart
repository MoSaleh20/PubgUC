import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:toast/toast.dart';
import '../../../constants.dart';
import '../../../databaseProvider.dart';

// ignore: must_be_immutable,camel_case_types
class showOrderDialog extends StatefulWidget {
  PubgUc pubg;
  String name;
  BuildContext context;
  @override
  _showOrderDialogState createState() =>
      _showOrderDialogState(pubg, name, context);
  showOrderDialog(this.pubg, this.context);
}

// ignore: camel_case_types
class _showOrderDialogState extends State<showOrderDialog> {
  _showOrderDialogState(this.pubg, this.name, this.context);
  String name;
  BuildContext context;
  PubgUc pubg;
  List<String> items = [];
  String defaultValue = "unknown";

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController costController =
        TextEditingController(text: "${pubg.cost}");
    var dateTimeGenerator = new DateTime.now();
    String now;
    if (dateTimeGenerator.second < 10)
      now =
          "${dateTimeGenerator.year}-${dateTimeGenerator.month}-${dateTimeGenerator.day} ${dateTimeGenerator.hour}:${dateTimeGenerator.minute}:0${dateTimeGenerator.second}";
    else
      now =
          "${dateTimeGenerator.year}-${dateTimeGenerator.month}-${dateTimeGenerator.day} ${dateTimeGenerator.hour}:${dateTimeGenerator.minute}:${dateTimeGenerator.second}";
    List<Customer> customers = [];

    return FutureBuilder(
        future: DatabaseProvider.db.custs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            customers = snapshot.data;
            allCustomers = customers;
            items = [];
            for (var i = 0; i < customers.length; i++) {
              items.add(customers[i].name);
            }
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                ),
                elevation: 0,
                backgroundColor: kPrimaryColor,
                child: SingleChildScrollView(
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
                                BorderRadius.circular(kDefaultPadding),
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
                              pubg.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              now,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
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
                                    labelText: "Cost",
                                    icon: Icon(Icons.money_rounded))),
                            TextField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"^\d*\.?\d*"))
                                ],
                                decoration: InputDecoration(
                                    labelText: "Price",
                                    icon:
                                        Icon(Icons.money_off_csred_outlined))),
                            SizedBox(
                              height: 22,
                            ),
                            DropdownButton<String>(
                              value: defaultValue,
                              style: TextStyle(color: Colors.white),
                              dropdownColor: Colors.white,
                              items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    "$value",
                                    style: TextStyle(color: kPrimaryColor),
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
                              alignment: Alignment.bottomRight,
                              child: FlatButton(
                                  onPressed: () {
                                    if (customers.isNotEmpty)
                                      for (var i = 0;
                                          i < customers.length;
                                          i++) {
                                        if (customers[i].name == defaultValue) {
                                          pubg.customerName = customers[i].name;
                                        }
                                      }
                                    if (priceController.text.isNotEmpty &&
                                        costController.text.isNotEmpty) {
                                      DatabaseProvider.db.insertInvoice(PubgUc(
                                        id: pubg.id,
                                        name: pubg.name,
                                        cost: double.parse(costController.text),
                                        customerName: pubg.customerName,
                                        price:
                                            double.parse(priceController.text),
                                        image: pubg.image,
                                        profit: double.parse(
                                                priceController.text) -
                                            double.parse(costController.text),
                                        date: "$dateTimeGenerator",
                                      ));
                                      // count must be done in the database provider
                                      //
                                      //
                                      //
                                      DatabaseProvider.db.updatePack(
                                        PubgUc(
                                          id: pubg.id,
                                          name: pubg.name,
                                          cost: pubg.cost,
                                          count: pubg.count + 1,
                                          image: pubg.image,
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                      priceController.text = "";
                                      Toast.show('Invoice Added!', context,
                                          backgroundColor: Colors.green[600]);
                                    } else {
                                      Toast.show(
                                          'Insert price & cost!', context);
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(kDefaultPadding),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 50,
                              )),
                        ),
                      ),
                    ],
                  ),
                ));
          } else
            return Text("No data");
        });
  }

  // showDialog(
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(kDefaultPadding),
  //         ),
  //         elevation: 0,
  //         backgroundColor: kPrimaryColor,
  //         child: contentBox(context),
  //       );
  //     },
  //     context: context);
}
