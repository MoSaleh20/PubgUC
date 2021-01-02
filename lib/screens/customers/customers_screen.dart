import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:toast/toast.dart';
import '../../constants.dart';
import '../../databaseProvider.dart';
import 'components/body.dart';

class CustomersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customersAppBar(size.width, context),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar customersAppBar(size, context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            _showDialog(context);
          },
        )
      ],
    );
  }

  void _showDialog(BuildContext context) {
    var dateTimeGenerator = new DateTime.now();
    String now =
        "${dateTimeGenerator.year}-${dateTimeGenerator.month}-${dateTimeGenerator.day}  ${dateTimeGenerator.hour}:${dateTimeGenerator.minute}";
    TextEditingController name = TextEditingController();
    contentBox(context) {
      return Stack(
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
                  "Add a new customer",
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
                    controller: name,
                    decoration: InputDecoration(icon: Icon(Icons.ac_unit))),
                SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: () {
                        if (name.text.isNotEmpty) {
                          DatabaseProvider.db.insertCustomer(Customer(
                            id: 1,
                            name: name.text,
                          ));
                          Navigator.of(context).pop();
                          Toast.show('Costomer Added!', context);
                        } else {
                          Toast.show('Enter a customer name!', context);
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
      );
    }

    showDialog(
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding),
            ),
            elevation: 0,
            backgroundColor: Colors.black,
            child: contentBox(context),
          );
        },
        context: context);
  }
}
