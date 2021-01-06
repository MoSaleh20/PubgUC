import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/drawer/drawer_screen.dart';
import 'package:toast/toast.dart';
import '../../constants.dart';
import '../../databaseProvider.dart';
import 'components/body.dart';
import 'package:plant_app/constants.dart';

class CustomersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: customersAppBar(size.width, context, "Customers"),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar customersAppBar(size, context, title) {
    return AppBar(
      toolbarHeight: 80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(60),
        ),
      ),
      backgroundColor: Colors.redAccent[400],
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      primary: true,
      leadingWidth: size * 0.3,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            splashColor: Colors.white,
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              width: 14,
              height: 14,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () {
            _showDialog(context);
          },
        ),
        SizedBox(
          width: size * 0.1,
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    List<Customer> customers = [];
    int id;

    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController(text: "+97");
    contentBox(context) {
      return SingleChildScrollView(
        child: FutureBuilder(
            future: DatabaseProvider.db.custs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                customers = snapshot.data;
                id = customers.last.id + 1;
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
                            "Add a new customer",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: name,
                            decoration: InputDecoration(
                              hintText: "Name",
                              icon: Icon(Icons.label_important),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            decoration: InputDecoration(
                              hintText: "Phone",
                              icon: Icon(Icons.phone),
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FlatButton(
                                onPressed: () {
                                  bool unique = true;
                                  for (var i = 0; i < customers.length; i++) {
                                    if (name.text == customers[i].name)
                                      unique = false;
                                  }
                                  if (name.text.isNotEmpty && unique) {
                                    DatabaseProvider.db.insertCustomer(Customer(
                                      id: id,
                                      name: name.text,
                                      phone: phone.text,
                                    ));
                                    Navigator.of(context).pop();
                                    Toast.show(
                                      'Costomer Added!',
                                      context,
                                    );
                                  } else if (name.text.isEmpty) {
                                    Toast.show(
                                      'Enter a customer name!',
                                      context,
                                    );
                                  } else if (!unique) {
                                    Toast.show(
                                      'This customer is already added!',
                                      context,
                                    );
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
                                Radius.circular(kDefaultPadding)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 50,
                            )),
                      ),
                    ),
                  ],
                );
              } else
                return Text('');
            }),
      );
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
