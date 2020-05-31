import 'package:flutter/material.dart';
import 'package:flutterapp/util/const.dart';
import 'package:flutterapp/widgets/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class GridComment extends StatelessWidget {

  final String userName;
  final String userImage;
  final String commentDate;
  final int userRating;
  final String userComment;
  final String commentURL;

  GridComment({
    Key key,
    @required this.userName,
    @required this.userImage,
    @required this.commentDate,
    @required this.userRating,
    @required this.userComment,
    @required this.commentURL})
      :super(key: key);

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      print("Can't Launch ${url}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width / 10,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.5,
                      child: Image.network(userImage),
                    ),
                  )
              ),

              /*Positioned(
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
              ),*/
            ],
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: SmoothStarRating(
              starCount: userRating,
              color: Constants.ratingBG,
              allowHalfRating: true,
              rating: userRating.toDouble(),
              size: 12.0,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "(" + "$userRating" + ")",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$commentDate",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$userName",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$userComment" + "   Click to read more",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
      onTap: (){
        launchURL(commentURL);
      },
    );
  }
}
