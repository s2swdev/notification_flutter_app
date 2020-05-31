import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
          "Notifications",
        ),
        elevation: 0.0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              title: Text("Notification-1"),
              onTap: (){},
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              title: Text("Notification-2"),
              onTap: (){},
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              title: Text("Notification-3"),
              onTap: (){},
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              title: Text("Notification-4"),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
