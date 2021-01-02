import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'databaseProvider.dart';

const kPrimaryColor = Colors.black;
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 20.0;

List<PubgUc> allInvoices = [];
List<Customer> allCustomers = [];

final List<PubgUc> uc = [
  PubgUc(id: 0, name: "Pubg UC 60", cost: 4.2),
  PubgUc(id: 1, name: "Pubg UC 120", cost: 7.8),
  PubgUc(id: 2, name: "Pubg UC 180", cost: 11.7),
  PubgUc(id: 3, name: "Pubg UC 240", cost: 15.6),
  PubgUc(id: 4, name: "Pubg UC 325", cost: 17.16),
  PubgUc(id: 5, name: "Pubg UC 445", cost: 24.16),
  PubgUc(id: 6, name: "Pubg UC 660", cost: 32),
  PubgUc(id: 7, name: "Pubg UC 720", cost: 35.2),
  PubgUc(id: 8, name: "Pubg UC 770", cost: 38.4),
  PubgUc(id: 9, name: "Pubg UC 840", cost: 41.6),
  PubgUc(id: 10, name: "Pubg UC 985", cost: 48),
  PubgUc(id: 11, name: "Pubg UC 1320", cost: 64),
  PubgUc(id: 12, name: "Pubg UC 1500", cost: 73.6),
  PubgUc(id: 13, name: "Pubg UC 1800", cost: 80),
  PubgUc(id: 14, name: "Pubg UC 1920", cost: 86.4),
  PubgUc(id: 15, name: "Pubg UC 2040", cost: 92.8),
  PubgUc(id: 16, name: "Pubg UC 2125", cost: 96),
  PubgUc(id: 17, name: "Pubg UC 2460", cost: 112),
  PubgUc(id: 18, name: "Pubg UC 3120", cost: 144),
  PubgUc(id: 19, name: "Pubg UC 3850", cost: 160),
  PubgUc(id: 20, name: "Pubg UC 4030", cost: 169.6),
  PubgUc(id: 21, name: "Pubg UC 4235", cost: 179.2),
  PubgUc(id: 22, name: "Pubg UC 4510", cost: 192),
  PubgUc(id: 23, name: "Pubg UC 5650", cost: 240),
  PubgUc(id: 24, name: "Pubg UC 6310", cost: 272),
  PubgUc(id: 25, name: "Pubg UC 8100", cost: 320),
  PubgUc(id: 26, name: "Pubg UC 8425", cost: 336),
  PubgUc(id: 27, name: "Pubg UC 8750", cost: 352),
  PubgUc(id: 28, name: "Pubg UC 9900", cost: 400),
  PubgUc(id: 29, name: "Pubg UC 11950", cost: 480),
  PubgUc(id: 30, name: "Pubg UC 13750", cost: 560),
  PubgUc(id: 31, name: "Pubg UC 16200", cost: 640),
  PubgUc(id: 32, name: "Pubg UC 17500", cost: 704),
  PubgUc(id: 33, name: "Pubg UC 20050", cost: 800),
  PubgUc(id: 34, name: "Pubg UC 24300", cost: 960),
];

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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
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
    this.country,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, country;
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
                            text: "$country".toUpperCase(),
                            style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\₪$price',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kPrimaryColor),
                    )
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

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
  );
}

bool home = true;
bool history = false;
bool profile = false;

List<PubgUc> loading() {
  List<PubgUc> invoices = [];
  FutureBuilder(
      future: DatabaseProvider.db.packs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          invoices = snapshot.data;
          print('123');
          return;
        } else
          print('11111111111111');
        return;
      });
  return invoices;
}
