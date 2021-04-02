import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'getwidget.dart';

class CustomSiteCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imagePath;
  final String ratings;
  const CustomSiteCard(
      {Key key, this.title, this.subTitle, this.imagePath, this.ratings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return GestureDetector(
        onTap: () {
          print("clicked on $title");
        },
        child: Stack(children: [
          GFCard(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 20, right: 40, left: 40, bottom: 0.0),
            elevation: 0,
            boxFit: BoxFit.scaleDown,
            image: CachedNetworkImage(
              imageUrl: imagePath,
            ),
            title: GFListTile(
              margin: EdgeInsets.only(top: 2),
              padding: EdgeInsets.zero,
              title: Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.zero,
                child: RatingBar(
                  itemSize: 15,
                  initialRating: double.parse(this.ratings),
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
              description: Container(
                alignment: Alignment.topLeft,
                child: Text(title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "Montserrat",
                    )),
              ),
              subTitle: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    subTitle,
                    style: TextStyle(
                        fontFamily: "Montserrat", color: Colors.black54),
                  )),
            ),
          ),
          Positioned(
            child: isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : GFAvatar(
                    radius: 13,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
            left: 45,
            top: 20.0,
          )
        ]));
  }
}
