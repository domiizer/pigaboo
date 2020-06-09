import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigaboo/model/Login.dart';
import 'package:pigaboo/model/Pasa.dart';
import 'package:pigaboo/model/constanc.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:pigaboo/page/DeliveryDetail.dart';
import 'package:pigaboo/page/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cart extends StatefulWidget {
  Pasa language;
  List countForSelected;
  String shopAlias;

  cart({this.language, this.countForSelected, this.shopAlias});

  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  SharedPreferences prefs;
  bool isLogin = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getUserData();
    super.didChangeDependencies();
  }

  Future<bool> _onBackPress() {
    Navigator.pop(context, widget.countForSelected);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.language.itemsinbasket),
          backgroundColor: Color.fromRGBO(255, 176, 3, 1),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, widget.countForSelected);
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  width: constanc.ScreenWidth,
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text('#')),
                      Expanded(
                        flex: 4,
                        child: Container(
//                          color: Colors.red,
                            height: 20,
                            child: Text(widget.language.list)),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
//                            color: Colors.green,
                              height: 20,
                              child:
                                  Center(child: Text(widget.language.amount)))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              height: 20,
//                            color: Colors.yellow,
                              alignment: Alignment.centerRight,
                              child: Text(widget.language.price))),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Flexible(
                flex: 5,
                child: Container(
//                    width: constanc.ScreenWidth,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.countForSelected.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(height: 15, color: Colors.black54),
                      itemBuilder: (BuildContext context, int index) {
                        return widget.countForSelected.isEmpty
                            ? null
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      //numberlist
                                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      child: Text((index + 1).toString())),
                                  Expanded(
                                      //menunamelist
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
//                                            color: Colors.red,
                                              child: Text(widget
                                                  .countForSelected[index]
                                                      ['menu_name']
                                                  .toString())),
                                          Container(
                                            child: widget.countForSelected[
                                                            index]['addon'][0]
                                                        ['name'] ==
                                                    'NO_ADDON'
                                                ? null
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: widget
                                                        .countForSelected[index]
                                                            ['addon']
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index2) {
                                                      return widget.countForSelected[
                                                                          index]
                                                                      ['addon']
                                                                  [0]['name'] ==
                                                              'NO_ADDON'
                                                          ? null
                                                          : Text(
                                                              ' - ' +
                                                                  widget.countForSelected[
                                                                              index]
                                                                          [
                                                                          'addon']
                                                                      [
                                                                      index2]['name'],
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .black54),
                                                            );
                                                    }),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    //amountlist
                                    flex: 1,
                                    child: Container(
//                                      color: Colors.green,
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                widget.countForSelected[index]
                                                    ['count']--;
                                                if (widget.countForSelected[
                                                        index]['count'] ==
                                                    0) {
                                                  widget.countForSelected
                                                      .removeAt(index);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: widget.countForSelected[
                                                        index]['menu_id'] ==
                                                    (widget.countForSelected[
                                                        index]['menu_id'])
                                                ? Text(widget
                                                    .countForSelected[index]
                                                        ['count']
                                                    .toString())
                                                : null),
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                widget.countForSelected[index]
                                                    ['count']++;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 15,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                  Expanded(
                                    //pricelist
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerRight,
//                                    color: Colors.yellow,
                                      child: Text(multi(
                                                  widget.countForSelected[index]
                                                          ['price'] +
                                                      int.parse(widget
                                                          .countForSelected[
                                                              index]['addon'][0]
                                                              ['price']
                                                          .toString()),
                                                  widget.countForSelected[index]
                                                      ['count'])
                                              .toString() +
                                          '฿'),
                                    ),
                                  ),
                                ],
                              );
                      }),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Flexible(
                flex: 1,
                child: Container(
//                  height: constanc.ScreenHeight*0.15,
                  child: Column(
                    children: <Widget>[
                      Text(widget.language.total +
                          amounttotal(widget.countForSelected).toString() +
                          '฿'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
//                          SizedBox(
//                            width: constanc.ScreenWidth/2-20,
//                          )
                            Expanded(
                                //clearOrder
                                child: Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  setState(() {
                                    widget.countForSelected = [];
                                    Navigator.pop(
                                        context, widget.countForSelected);
                                  });
                                },
                                child: Text(
                                  widget.language.clear,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            )),
                            Expanded(
                              //confirmOrder
                              child: Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  color: Colors.green,
                                  onPressed: () {
                                    isLogin
                                        ? _showDialog()
                                        : _navigateToLogin();
                                  },
                                  child: Text(
                                    widget.language.placeorder,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getLocation() async {
      await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) => _confirmOrder(value));
  }

  _showDialog() {
    var txt = TextEditingController();
    if (prefs.getString('address') != 'NO_ADDRESS'){
      txt.text=prefs.getString('address');
    }

    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Row(
                children: <Widget>[
                  new Container(
                    // padding: new EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new Text(
                      'Address',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'helvetica_neue_light',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // dialog centre
            new Expanded(
              child: new Container(
                  child: new TextField(
                    controller: txt,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: new EdgeInsets.only(
                      left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                  hintText: ' Your address',
                  hintStyle: new TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
              )),
              flex: 2,
            ),

            // dialog bottom
            Expanded(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  prefs.setString('address',txt.text);
                  getLocation();
                },
                color: Colors.green,
                padding:EdgeInsets.all(16.0),
                child: new Text(
                  widget.language.placeorder,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, child: dialog);
  }

  _navigateToLogin() async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Login checklogin = await Navigator.push(
            context,
            // ignore: missing_return
            CupertinoPageRoute(
                builder: (context) => login(language: widget.language)))
        .then((value) {
      setState(() {
        isLogin = prefs.getBool('status');
        print(isLogin);
      });
    });
  }

  _confirmOrder(Position position) async {
    List menuOrderList = new List();
    for (int i = 0; i < widget.countForSelected.length; i++) {
      for (int j = 0; j < widget.countForSelected[i]['addon'].length; j++) {
        if (widget.countForSelected[i]['addon'][j]['name'] == 'NO_ADDON') {
          menuOrderList.add({
            'itemId': widget.countForSelected[i]['menu_id'],
            'arrAddOn': null,
            'amount': widget.countForSelected[i]['count'],
            'extraComments': ''
          });
        } else {
          menuOrderList.add({
            'itemId': widget.countForSelected[i]['menu_id'],
            'arrAddOn': widget.countForSelected[i]['addon'][j]['name'],
            'amount': widget.countForSelected[i]['count'],
            'extraComments': ''
          });
        }
      }
    }
    String myURL = "https://api.pigaboo.me/createNewOrder";
    http.post(myURL, headers: {
      'Accept': 'application/json'
    }, body: {
      "customerId": prefs.getString('customerId'),
      "deliveryAddress": prefs.getString('address'),
      "deliveryMethod": '1',
      "deliveryRound": '1',
      "extraComments": '',
      "lat": position.latitude.toString(),
      "lng": position.longitude.toString(),
      "menuOrderList": menuOrderList.toString(),
      "paymentMethod": '1',
      "shopAlias": widget.shopAlias,
      "telephoneNumber": prefs.getString('phoneNumber'),
    }).then((response) {
      print('responseStatuscode : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => DeliveryDetail(language: widget.language)));
      } else {
        print('not response');
        throw Exception('error :(');
      }
    });
  }

  multi(int num1, num2) {
    return num1 * num2;
  }

  int amounttotal(List<dynamic> countForSelected) {
    int aamount = 0;
    print(countForSelected);
    for (int i = 0; i < countForSelected.length; i++) {
      for (int j = 0; j < countForSelected[i]['addon'].length; j++) {
        aamount +=
            int.parse(countForSelected[i]['addon'][j]['price'].toString()) *
                countForSelected[i]['count'];
      }
      aamount += countForSelected[i]['price'] * countForSelected[i]['count'];
    }
    return aamount;
  }

  getUserData() async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    if (prefs.getBool('status') != null) {
      setState(() {
        print('getuser');
        isLogin = prefs.getBool('status');
      });
    }
  }
}
