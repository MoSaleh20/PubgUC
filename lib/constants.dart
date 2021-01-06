import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'databaseProvider.dart';

var kPrimaryColor = Colors.black;
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 20.0;

List<PubgUc> allInvoices = [];
List<Customer> allCustomers = [];

Widget orderItem(invoices, index) {
  DateTime now = DateTime.parse(invoices[index].date);
  return Container(
    child: ListTile(
      focusColor: Colors.white,
      subtitle:
          Text('${invoices[index].customerName}  -  ${invoices[index].price}'),
      title: Text(invoices[index].name),
      trailing: Text(
          '${now.year}-${now.month}-${now.day}  ${now.hour}:${now.minute}'),
    ),
  );
}

List<PubgUc> uc = [];

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.title,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title;
  final double price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      height: size.height * 0.35,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Column(children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                // child: Image.asset(
                //   image,
                //   fit: BoxFit.fill,
                // ),
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "$title\n".toUpperCase(),
                              style: Theme.of(context).textTheme.button),
                          TextSpan(
                            text: "₪ $price",
                            style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class UCcards extends StatelessWidget {
  UCcards(
      {Key key,
      this.image,
      this.title,
      this.country,
      this.price,
      this.press,
      this.icon,
      this.height})
      : super(key: key);

  final String image, title, country;
  final double price;
  final Function press;
  double height;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding,
          bottom: kDefaultPadding,
          right: kDefaultPadding),
      width: size.width * 0.37,
      height: this.height,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Column(children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "$title\n".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(fontSize: 14)),
                          TextSpan(
                            text: '\₪$price',
                            style: TextStyle(
                              fontSize: 14,
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    icon,
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

AppBar customerAppBar(context, title) {
  if (title == null) title = "";
  var heading = Text(title);
  return AppBar(
    title: heading,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}

AppBar historyAppBar(title, size) {
  return AppBar(
    toolbarHeight: 80,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(60),
      ),
    ),
    backgroundColor: Colors.green[500],
    title: Text(title),
    centerTitle: true,
    elevation: 0,
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
  );
}

bool home = true;
bool history = false;
bool profile = false;

fetchPacks() {
  FutureBuilder(
      future: DatabaseProvider.db.orders,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          allInvoices = snapshot.data;
          print('pack done');
          return;
        } else
          print('pack not done');
        return;
      });
  print('packs done');
}

fetchCustomers() {
  FutureBuilder(
      future: DatabaseProvider.db.custs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          allCustomers = snapshot.data;
          print('done');
          return;
        } else
          print('not done');
        return;
      });
  print('all done');
}
