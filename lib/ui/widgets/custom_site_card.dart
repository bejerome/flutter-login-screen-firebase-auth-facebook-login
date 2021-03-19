import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'getwidget.dart';

class CustomSiteCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imagePath;
  const CustomSiteCard({Key key, this.title, this.subTitle, this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("clicked on $title");
      },
      child: GFCard(
        borderRadius: BorderRadius.circular(10),
        margin: EdgeInsets.only(top: 10, right: 40, left: 40, bottom: 0.0),
        elevation: 5,
        boxFit: BoxFit.cover,
        image: Image.asset(
          imagePath,
        ),
        title: GFListTile(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          title: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
          subTitle: Container(
              margin: EdgeInsets.only(top: 10, bottom: 0),
              alignment: Alignment.center,
              child: Text(
                subTitle,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Color(COLOR_PRIMARY)),
              )),
          description: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.zero,
            child: RatingBar(
              itemSize: 15,
              initialRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Image.asset(
                  'assets/images/heart.png',
                  color: Color(COLOR_PRIMARY),
                ),
                half: Image.asset(
                  'assets/images/heart_half.png',
                  color: Color(COLOR_PRIMARY),
                ),
                empty: Image.asset(
                  'assets/images/heart.png',
                  color: Colors.grey,
                ),
              ),
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ),
      ),
    );
  }
}
