import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigaboo/model/Pasa.dart';
import 'package:pigaboo/model/constanc.dart';
import 'package:pigaboo/page/pigAboo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class DeliveryDetail extends StatefulWidget {
  Pasa language;

  DeliveryDetail({this.language});

  @override
  _DeliveryDetailState createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  SharedPreferences prefs;

  @override
  void initState() {
    LoadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Image.network('https://6.viki.io/image/43caa85b2af94eb198f0050e9a1a857c.jpeg?s=900x600&e=t'),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _onBackPressed() {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => pigAboo(),));
  }

  LoadData()async{
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString('customerId'));
    await http
        .post('https://api.pigaboo.me/getAllUserOrdersActive',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          ' customerId': prefs.getString('customerId'),
        }))
        .then((response) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      debugPrint(response.body, wrapWidth: 1024);
        });
  }
}
