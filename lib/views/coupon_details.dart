import 'package:flutter/material.dart';
import 'package:flutterapp/views/notifications.dart';
import 'package:flutterapp/util/const.dart';
import 'package:flutterapp/widgets/badge.dart';
import 'package:flutterapp/widgets/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class CouponDetails extends StatefulWidget {
  final List couponDetails; //restaurantId;
  CouponDetails(this.couponDetails);
  @override
  _CouponDetailsState createState() => _CouponDetailsState(couponDetails);
}

class _CouponDetailsState extends State<CouponDetails> {
  List data;
  _CouponDetailsState(this.data);
  bool isFav = false;

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      print("Can't Launch ${url}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Item Details",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      data[0]["image_url"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: (){},
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        isFav
                            ?Icons.favorite
                            :Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            Text(
              data[0]["name"],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: double.parse(data[0]["rating"]),
                    size: 12.0,
                  ),
                  SizedBox(width: 10.0),

                  Text(
                    data[0]["rating"] + " (" +  data[0]["review_count"] + " Reviews)",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    data[0]["category_1"] + ", " + data[0]["category_2"] + ", " + data[0]["category_3"],
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10.0),

                  Text(
                    " |  " + data[0]["price"] + " (price)",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      //color: Theme.of(context).accentColor,
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: 20.0),

            Text(
              "Restaurant Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            SizedBox(height: 1.0),

            ListTile(
              title: Text(
                "Address",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                data[0]["display_address"],
              ),

              trailing: IconButton(
                icon: Icon(
                  Icons.map,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "Map",
              ),
            ),

            ListTile(
              title: Text(
                "Phone",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                data[0]["Org_display_phone"],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.phone,
                  size: 20.0,
                ),
                onPressed: (){
                  launch("tel:" + data[0]["Org_display_phone"]);
                },
                tooltip: "Map",
              ),
            ),

            ListTile(
              title: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                data[0]["menu_url"],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 20.0,
                ),
                onPressed: (){
                  launchURL(data[0]["menu_url"]);
                },
                tooltip: "Map",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
