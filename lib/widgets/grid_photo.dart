import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GridPhoto extends StatelessWidget {

  final String moreImgURL;
  final String imgURL;

  GridPhoto({
    Key key,
    @required this.moreImgURL,
    @required this.imgURL})
      :super(key: key);

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);//, forceSafariVC: true, forceWebView: true);
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
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 4.5,
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.5,
                    child: Image.network(imgURL),
                  ),
                )
              ),
            ],
          ),
        ],
      ),
      onTap: (){
        launchURL(moreImgURL);
      },
    );
  }
}
