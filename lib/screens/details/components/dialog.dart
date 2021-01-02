import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';
import '../../../databaseProvider.dart';

class showOrderDialog extends StatefulWidget {
  int id;
  BuildContext context;
  @override
  _showOrderDialogState createState() => _showOrderDialogState(id, context);
  showOrderDialog(this.id, this.context);
}

class _showOrderDialogState extends State<showOrderDialog> {
  _showOrderDialogState(this.id, this.context);
  BuildContext context;
  int id;
  @override
  Widget build(BuildContext context) {
    List<String> items = ["a", "b"];
    String defaultValue = "a";
    var dateTimeGenerator = new DateTime.now();
    String now =
        "${dateTimeGenerator.year}-${dateTimeGenerator.month}-${dateTimeGenerator.day}  ${dateTimeGenerator.hour}:${dateTimeGenerator.minute}";
    TextEditingController price = TextEditingController();
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
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
                  borderRadius: BorderRadius.circular(kDefaultPadding),
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    now,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      controller: price,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*"))
                      ],
                      decoration:
                          InputDecoration(icon: Icon(Icons.money_rounded))),
                  SizedBox(
                    height: 22,
                  ),
                  DropdownButton<String>(
                    dropdownColor: Colors.black,
                    items: items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: defaultValue,
                        child: Text(
                          "$value",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                        onPressed: () {
                          if (price.text.isNotEmpty) {
                            DatabaseProvider.db.insertInvoice(PubgUc(
                              id: uc[widget.id].id,
                              name: uc[widget.id].name,
                              cost: uc[widget.id].cost,
                              price: double.parse(price.text),
                              image: uc[widget.id].image,
                              date: now,
                            ));
                            Navigator.of(context).pop();
                            Toast.show('Invoice Added!', context);
                          } else {
                            Toast.show('Insert a price!', context);
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
                backgroundColor: Colors.black,
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
  }

  // showDialog(
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(kDefaultPadding),
  //         ),
  //         elevation: 0,
  //         backgroundColor: Colors.black,
  //         child: contentBox(context),
  //       );
  //     },
  //     context: context);
}
