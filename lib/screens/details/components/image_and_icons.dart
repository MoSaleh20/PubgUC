import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ImageAndIcons extends StatelessWidget {
  const ImageAndIcons({
    Key key,
    @required this.size,
    @required this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: size.height,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 8.4),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 27),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[300]),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding * 1.8),
                            icon: SvgPicture.asset(
                              "assets/icons/back_arrow.svg",
                              height: 50,
                              width: 50,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.75,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(63),
                  bottomLeft: Radius.circular(63),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 60,
                    color: kPrimaryColor.withOpacity(0.29),
                  ),
                ],
                color: kPrimaryColor,
                image: DecorationImage(
                  alignment: Alignment.bottomLeft,
                  fit: BoxFit.contain,
                  image: AssetImage("assets/images/pubgman.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
