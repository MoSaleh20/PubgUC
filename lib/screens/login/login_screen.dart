import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.fromLTRB(15.0, size.height * 0.2, 0.0, 0.0),
                  child: Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      size.width * 0.56, size.height * 0.2, 0.0, 0.0),
                  child: Text(
                    '...',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                  top: size.height * 0.2, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Whats your name?',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, size.height * 0.01, 0, 0),
                      height: size.height * 0.07,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: kPrimaryColor,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'Enter',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 195,
                  ),
                  Text(
                    '© 2021 MohammadSaleh. All Rights Reserved.',
                    style: TextStyle(
                        fontFamily: '',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  )
                ],
              )),
        ]));
  }
}
