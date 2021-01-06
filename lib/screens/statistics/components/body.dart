import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/monthly.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import '../../../databaseProvider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<PubgUc> history;
  @override
  Widget build(BuildContext context) {
    List<PubgUc> invoices = [];
    List<PubgUc> packs = [];

    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(children: [
          FutureBuilder(
              future: DatabaseProvider.db.orders,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  invoices = snapshot.data;
                  allInvoices = invoices;
                  double profit = 0;
                  double profitThisMonth = 0;
                  int countThisMonth = 0;
                  int count = 0;
                  DateTime now = DateTime.now();
                  for (var i = 0; i < invoices.length; i++) {
                    profit += invoices[i].price - invoices[i].cost;
                    DateTime date = DateTime.parse(invoices[i].date);
                    if (date.month == now.month) {
                      profitThisMonth += invoices[i].price - invoices[i].cost;
                      countThisMonth++;
                      count++;
                    }
                  }
                  profit = double.parse((profit).toStringAsFixed(2));
                  profitThisMonth =
                      double.parse((profitThisMonth).toStringAsFixed(2));
                  List<String> months = [];
                  DateTime date;
                  for (var i = 0; i < invoices.length; i++) {
                    date = DateTime.parse(invoices[i].date);
                    months.add("${date.year}-${date.month}");
                  }
                  months = months.toSet().toList();
                  String time;
                  List<monthly> allMonthsData = [];
                  for (var j = 0; j < months.length; j++) {
                    double monthlyProfit = 0;

                    for (var i = 0; i < allInvoices.length; i++) {
                      time =
                          "${DateTime.parse(allInvoices[i].date).year}-${DateTime.parse(allInvoices[i].date).month}";
                      if (months[j] == time) {
                        monthlyProfit += allInvoices[i].profit;
                      }
                    }
                    monthlyProfit =
                        double.parse((monthlyProfit).toStringAsFixed(2));
                    allMonthsData
                        .add(monthly(name: months[j], profit: monthlyProfit));
                  }
                  allMonthsData.sort((a, b) {
                    return b.name
                        .toString()
                        .toLowerCase()
                        .compareTo(a.name.toString().toLowerCase());
                  });
                  print(allMonthsData.toString());
                  return FutureBuilder(
                      future: DatabaseProvider.db.packs,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          packs = snapshot.data;
                          uc = packs;
                          packs.sort((a, b) {
                            return b.count
                                .toString()
                                .toLowerCase()
                                .compareTo(a.count.toString().toLowerCase());
                          });
                          Size size = MediaQuery.of(context).size;

                          return Column(children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF6448FE),
                                        Color(0xFF5E9FFF)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Column(children: [
                                  statItem("Net Profit", profit),
                                  statItem("Number of orders", count),
                                  statItem(
                                      "Profit this month", profitThisMonth),
                                  statItem("Orders this month", countThisMonth),
                                ])),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 15,
                              endIndent: 15,
                            ),
                            Container(
                                height: packs.length * 50.0 + 100,
                                width: size.width,
                                child: PageView(children: [
                                  Column(children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(35, 15, 60, 0),
                                        height: 30,
                                        width: size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'count',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '       Pack Name',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Profit',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        )),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: packs.length,
                                      itemBuilder: (context, index) {
                                        return ucItem(packs, index);
                                      },
                                    )
                                  ]),
                                  Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                              35, 15, 60, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '     Month',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Profit',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          )),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: allMonthsData.length,
                                        itemBuilder: (context, index) {
                                          return monthlyItem(
                                              packs, allMonthsData, index);
                                        },
                                      ),
                                    ],
                                  )
                                ])),
                          ]);
                        } else
                          return Text('No Date');
                      });
                } else
                  return Text('No Date');
              })
        ]));
  }
}

statItem(title, value) {
  return ListTile(
    title: Text(
      "$title",
      style: TextStyle(
        fontSize: 25,
        color: Colors.black,
      ),
    ),
    trailing: Text(
      "$value",
      style: TextStyle(fontSize: 25),
    ),
  );
}

Widget ucItem(packs, index) {
  double profit = 0;
  for (var i = 0; i < allInvoices.length; i++) {
    if (allInvoices[i].name == packs[index].name) {
      profit += allInvoices[i].profit;
    }
  }
  profit = double.parse((profit).toStringAsFixed(2));
  return Container(
    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6448FE), Color(0xFF5E9FFF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("${packs[index].count} ${packs[index].name}",
                    style: GoogleFonts.aldrich(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    )))),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("$profit",
                    style: GoogleFonts.aldrich(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    )))),
          ],
        )),
  );
}

Widget monthlyItem(packs, allMonthsData, index) {
  return Container(
    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6448FE), Color(0xFF5E9FFF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("${allMonthsData[index].name}",
                    style: GoogleFonts.aldrich(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    )))),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("${allMonthsData[index].profit}",
                    style: GoogleFonts.aldrich(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    )))),
          ],
        )),
  );
}
