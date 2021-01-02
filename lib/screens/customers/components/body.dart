import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/screens/customer/customer_screen.dart';
import '../../../databaseProvider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Customer> customers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      FutureBuilder(
          future: DatabaseProvider.db.custs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              customers = snapshot.data;
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  if (!customers[index].inDept) {
                    customers[index].dept = 0;
                  }
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomerScreen(customers[index]),
                            ));
                      },
                      child: Container(
                        child: ListTile(
                          focusColor: Colors.white,
                          title: Text(customers[index].name),
                          subtitle: Text('${customers[index].dept}'),
                          trailing: Icon(
                            Icons.report_problem,
                            color: Colors.yellowAccent[700],
                          ),
                        ),
                      ));
                },
              );
            } else
              return Text('No Data');
          })
    ]));
  }
}
