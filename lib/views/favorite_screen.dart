import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen();
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>{
  _FavoriteScreenState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter'),
      ),
      body: Center(
        child: Text('This is a favorite page'),
      ),
    );
  }
}

