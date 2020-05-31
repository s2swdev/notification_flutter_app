import 'package:flutter/material.dart';
import 'package:flutterapp/util/const.dart';
import 'package:flutterapp/views/coupon_details.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen >{

  String url = Constants.apiLink + 'product/read_coupon.php';
  List data, data_restaurant;
  List data_detail;
  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["records"];
    });
  }

  Future<String> makeRequest_details(int i) async {
    String url = Constants.apiLink + 'product/read_detail.php?id=' + data[i]["restaurant"]["Org_id"];
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data_detail = extractdata["restaurants"];

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new CouponDetails(data_detail)));
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Coupons & Deals'),
        ),
        body: new ListView.builder(
            itemCount: data == null? 0: data.length,
            itemBuilder: (BuildContext context, i) {
              return new ListTile(
                title: new Text(data[i]["Discount_offered"]),
                subtitle: new Text(data[i]["restaurant"]["name"]),
                leading: new CircleAvatar(
                  backgroundImage: new NetworkImage(data[i]["restaurant"]["image_url"]),
                ),
                onTap: () {
                  this.makeRequest_details(i);

                },
              );
            })
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SecondPage extends StatelessWidget {
  SecondPage(this.data);
  final data;
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(title: new Text(data["restaurant"]["name"])),
    body: Padding(
      padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),

      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Image.network(
                  data["restaurant"]["image_url"],
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          data["restaurant"]["name"],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          data["restaurant"]["rating"],
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                flex: 3,
              ),
            ],
          ),

          Divider(),
          Container(height: 15.0),

          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Coupon Details".toUpperCase(),
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ListTile(
            title: Text(
              "Coupon Code",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            subtitle: Text(
              data["CouponCode"],
            ),
          ),

          ListTile(
            title: Text(
              "Discount_offered",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            subtitle: Text(
              data["Discount_offered"],
            ),
          ),

          ListTile(
            title: Text(
              "Coupon_Start_date",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            subtitle: Text(
              data["Coupon_Start_date"],
            ),
          ),

          ListTile(
            title: Text(
              "Coupon_Expiry_date",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            subtitle: Text(
              data["Coupon_Expiry_date"],
            ),
          ),

          ListTile(
            title: Text(
              "Fineprint",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            subtitle: Text(
              data["Fineprint"],
            ),
          ),

          Divider(),
          Container(height: 15.0),

          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Restaurant Details".toUpperCase(),
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ListTile(
            title: Text(
              "Address",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            subtitle: Text(
              data["Address"]["Street_1"],
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
              data["restaurant"]["display_phone"],
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.phone,
                size: 20.0,
              ),
              onPressed: (){},
              tooltip: "Call",
            ),
          ),
        ],
      ),
    ),
  );
}

