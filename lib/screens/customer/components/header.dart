import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import '../../../constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:plant_app/screens/customer/customer_screen.dart';

class Header extends StatefulWidget {
  Customer customer;
  Header({Key key, @required this.size, this.customer}) : super(key: key);

  final Size size;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: widget.size.height * 0.35,
        margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                height: widget.size.height,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/profile.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          Text(
                            widget.customer.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Image.asset(
                                "assets/images/whatsapp.png",
                                scale: 1,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.only(right: 20),
                              onPressed: () async {
                                if (widget.customer.phone != null) {
                                  String message = "";
                                  var url =
                                      "whatsapp://send?phone=${widget.customer.phone}&text=${Uri.parse(message)}";
                                  if (await canLaunch(url))
                                    await launch(url);
                                  else
                                    throw "There is an issue, try again later!";
                                } else
                                  Toast.show(
                                      "Can't dial this customer!", context);
                              }),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Row(
                          children: [
                            Info(widget.customer.dept, "Balance"),
                            Info(widget.customer.payment, "Payments"),
                            Container(
                              margin: EdgeInsets.only(
                                  right: widget.size.width * 0.1),
                              child: IconButton(
                                icon: Icon(
                                  Icons.money,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _showDialog(context, widget.customer);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, customer) {
    TextEditingController paymentController = TextEditingController();
    contentBox(context) {
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
                    "Insert a new Payment",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      controller: paymentController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                          icon: Icon(Icons.label), hintText: "Payment")),
                  SizedBox(
                    height: 22,
                  ),
                  //
                  //fix the refresh
                  //after
                  //pressing
                  //the add button
                  //
                  //fix the refresh
                  //after
                  //pressing
                  //the add button
                  //
                  //
                  //fix the refresh
                  //after
                  //pressing
                  //the add button
                  //
                  //
                  //
                  //fix the refresh
                  //after
                  //pressing
                  //the add button
                  //
                  //
                  //
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          DatabaseProvider.db.updateCustomer(Customer(
                              id: customer.id,
                              name: customer.name,
                              dept: customer.dept,
                              payment: customer.payment +
                                  double.parse(paymentController.text)));
                        });
                        Navigator.of(context).pop();
                        Toast.show("Payment added", context);
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
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
        ),
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

class Info extends StatelessWidget {
  final double amount;
  final String text;

  Info(this.amount, this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Text(
              "$amount",
              textScaleFactor: 1.3,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              text,
              textScaleFactor: 0.9,
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }
}
