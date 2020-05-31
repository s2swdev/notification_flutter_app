import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/views/profile.dart';
import 'package:flutterapp/views/favorite_screen.dart';
import 'package:flutterapp/views/home.dart';
import 'package:flutterapp/views/notifications.dart';
import 'package:flutterapp/views/coupon_list.dart';
import 'package:flutterapp/views/search.dart';
import 'package:flutterapp/views/settings.dart';
import 'package:flutterapp/util/const.dart';
import 'package:flutterapp/widgets/badge.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  final String firstName, lastName;
  MainScreen(this.firstName, this.lastName);
  @override
  _MainScreenState createState() => _MainScreenState(firstName, lastName);
}

class _MainScreenState extends State<MainScreen> {
  String firstName, lastName;
  _MainScreenState(this.firstName, this.lastName);
  PageController _pageController;
  int _page = 0;

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      print("Can't Launch ${url}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            Constants.appName,
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
              tooltip: "Notifications",
            ),
          ],
        ),

        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('UserName'),
                accountEmail: new Text('testemail@test.com'),
                currentAccountPicture: new CircleAvatar(
                  //backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
                ),
              ),
              ListTile(
                title: Text("Settings"),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Settings())),
              ),
            ],
          ),
        ),

        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            FavoriteScreen(),
            SearchScreen(),
            CartScreen(),
            Profile(),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width:7),
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 24.0,
                ),
                color: _page == 0
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(0),
              ),

              IconButton(
                icon:Icon(
                  Icons.favorite,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(1),
              ),

              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(2),
              ),

              IconButton(
                icon: IconBadge(
                  icon: Icons.money_off,
                  size: 24.0,
                ),
                color: _page == 3
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(3),
              ),

              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24.0,
                ),
                color: _page == 4
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(4),
              ),

              SizedBox(width:7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(
            Icons.search,
          ),
          onPressed: ()=>_pageController.jumpToPage(2),
        ),

      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
