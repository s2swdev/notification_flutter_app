import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/util/const.dart';
import 'package:flutterapp/providers/app_provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Settings"),),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? SizedBox()
                : ListTile(
              title: Text(
                "Dark Theme",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              trailing: Switch(
                value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                    ? false
                    : true,
                onChanged: (v) async{
                  if (v) {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.darkTheme, "dark");
                  } else {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.lightTheme, "light");
                  }
                },
                activeColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
