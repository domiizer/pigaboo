import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigaboo/model/Pasa.dart';

class proflie extends StatefulWidget {
  Pasa language;

  proflie({this.language});

  @override
  _proflieState createState() => _proflieState();
}

class _proflieState extends State<proflie> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 176, 3, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/Logo_black.png',
              scale: 8,
            ),
            Column(
              children: <Widget>[
                Text(
                  'PIGABOO',
                ),
                Text(widget.language.fromdoortodoor),
              ],
            ),
            Expanded(child: Container(height: 10,),),
            GestureDetector(
              child: Container(
                child: Text('Log out'),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://66.media.tumblr.com/4afef2cced92402da30455419967a92a/3d47367140418a79-50/s250x400/88c8c9d9ffda85c0fde4f0518745d801c3e924a0.jpg'),
                ),
                Text('firstname'),
                Text('lastname'),
                Text('address'),
                Text('customerId'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
