import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigaboo/model/Pasa.dart';
import 'package:pigaboo/model/constanc.dart';
import 'package:pigaboo/page/pigAboo.dart';

class DeliveryDetail extends StatefulWidget {
  Pasa language;

  DeliveryDetail({this.language});

  @override
  _DeliveryDetailState createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 176, 3, 1),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            color:Colors.green,
            child: Container(
              width: constanc.ScreenWidth,
              height: constanc.ScreenHeight*0.2,
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _onBackPressed() {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => pigAboo(),));
  }
}
