import 'package:flutter/material.dart';
import 'package:plant_app/screens/statistics/statistics_screen.dart';
import 'package:plant_app/constants.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: size.height,
            color: kPrimaryColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF6448C1), Color(0xFF5E9FFF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52.0,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            "Mega Calc",
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "BY. Mohammad Saleh",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF6448FE), Color(0xFF5E9FFF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        title: Text("Favorites"),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6448FE), Color(0xFF5E9FFF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StatisticsScreen()));
                        },
                        leading: Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        title: Text("Stats"),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF6448FE), Color(0xFF5E9FFF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        title: Text("About"),
                      )),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    '© 2021 MohammadSaleh. All Rights Reserved.',
                    style: TextStyle(
                        fontFamily: '',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
