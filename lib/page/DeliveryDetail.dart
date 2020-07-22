import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pigaboo/model/Pasa.dart';
import 'package:pigaboo/model/constanc.dart';
import 'package:pigaboo/page/pigAboo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryDetail extends StatefulWidget {
  Pasa language;
  String order_code;
  String maincolor;
  DeliveryDetail({this.language, this.order_code, this.maincolor});

  @override
  _DeliveryDetailState createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  SharedPreferences prefs;
  double calcuper = 0.0;
  List menu_list = new List();
  Timer timers;
  double radius = 5.0;
  dynamic paymentObj;
  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
    trackMyOrder();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    print(widget.order_code);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoad == true
        ? Scaffold(
            body: Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(hexColor(widget.maincolor)),
                automaticallyImplyLeading: false,
              ),
              body: SingleChildScrollView(
                child: Container(
//                  color: Colors.black54,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        width: constanc.ScreenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(radius)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: constanc.ScreenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      topRight: Radius.circular(radius))),
                              child: Center(
                                child: Text(
                                  'head',
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            ),
                            Container(
                              width: constanc.ScreenWidth,
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(radius)),
                              child: Center(
                                  child: Text(
                                'Process',
                                style: TextStyle(fontSize: 20),
                                textScaleFactor: 1.0,
                              )),
                            ),
                            Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: LinearPercentIndicator(
//                    width: MediaQuery.of(context).size.width - 50,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2000,
                                    percent: calcuper,
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.greenAccent,
                                  ),
                                ),
                                Positioned(
                                  left: (constanc.ScreenWidth / 3 * 0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                      'images/check.png',
                                      scale: 20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Image.asset(
                                  'images/OrderPlaced.png',
                                  scale: 10.0,
                                ),
                                Image.asset(
                                  'images/OrderPrepare.png',
                                  scale: 10.0,
                                ),
                                Image.asset(
                                  'images/OrderOnTheWay.png',
                                  scale: 10.0,
                                ),
                                Image.asset(
                                  'images/OrderDelivered.png',
                                  scale: 10.0,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(30),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                onPressed: () {
                                  _onBackPressed();
                                },
                                child: Text(
                                  'Back to homepage',
                                  textScaleFactor: 1.0,
                                ),
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //listmenu
                        //order list
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        width: constanc.ScreenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(radius)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: constanc.ScreenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      topRight: Radius.circular(radius))),
                              child: Center(
                                  child: Text(
                                widget.language.cartlist,
                                textScaleFactor: 1.0,
                              )),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    //menunamelist
                                    flex: 4,
                                    child: Container(
                                        child: Text(' ' + widget.language.list,
                                            textScaleFactor: 1.0))),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                    widget.language.amount,
                                    textScaleFactor: 1.0,
                                  )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                    'price',
                                    textScaleFactor: 1.0,
                                  )),
                                ),
                              ],
                            ),
                            Divider(height: 10, color: Colors.black54),
                            Container(
//                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: menu_list.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(
                                              height: 15,
                                              color: Colors.black54),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return menu_list.isEmpty
                                        ? null
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                  //menunamelist
                                                  flex: 4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                          child: Text(
                                                              ' ' +
                                                                  menu_list[index]
                                                                          [
                                                                          'name']
                                                                      .toString(),
                                                              textScaleFactor:
                                                                  1.0)),
                                                      Container(
                                                        child: menu_list[index][
                                                                    'arrAddOns'] ==
                                                                null
                                                            ? null
                                                            : ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                itemCount: menu_list[
                                                                            index]
                                                                        [
                                                                        'arrAddOns']
                                                                    .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index2) {
                                                                  return Text(
                                                                    ' - ' +
                                                                        menu_list[index]['arrAddOns']
                                                                            [
                                                                            index2],
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black54),
                                                                  );
                                                                }),
                                                      ),
                                                    ],
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Text(
                                                  menu_list[index]['count']
                                                      .toString(),
                                                  textScaleFactor: 1.0,
                                                )),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Text(
                                                  menu_list[index]['price']
                                                      .toString(),
                                                  textScaleFactor: 1.0,
                                                )),
                                              ),
                                            ],
                                          );
                                  }),
                            ),
                            Divider(height: 10, color: Colors.black54),
                          ],
                        ),
                      ),
                      Container(
                        //currentdata
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        width: constanc.ScreenWidth,
//                color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(radius)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      topRight: Radius.circular(radius))),
                              width: constanc.ScreenWidth,
//                      color: Colors.green,
                              child: Center(
                                  child: Text(
                                widget.language.deliveryDetail,
                                textScaleFactor: 1.0,
                              )),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              width: constanc.ScreenWidth,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radius))),
                              child: Text(
                                ' ' +
                                    prefs.getString('firstName') +
                                    ' ' +
                                    prefs.getString('lastName'),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              width: constanc.ScreenWidth,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radius))),
                              child: Text(
                                ' ' + prefs.getString('phoneNumber'),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: constanc.ScreenWidth,
                              height: constanc.ScreenHeight / 10,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radius))),
                              child: Text(
                                ' ' + prefs.getString('address'),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //payment
                        margin: EdgeInsets.all(20),
                        width: constanc.ScreenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(radius)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              width: constanc.ScreenWidth,
                              child: Center(
                                  child: Text(
                                'การชำระเงิน',
                                textScaleFactor: 1.0,
                              )),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      topRight: Radius.circular(radius))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.payment),
                                Text(
                                  ' ' + widget.language.cash,
                                  textScaleFactor: 1.0,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  widget.language.foodfees,
                                  textScaleFactor: 1.0,
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  ' \$' + paymentObj['food_fee'].toString(),
                                  textScaleFactor: 1.0,
                                )))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  widget.language.deliveryfee,
                                  textScaleFactor: 1.0,
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  ' \$' + paymentObj['delivery_fee'].toString(),
                                  textScaleFactor: 1.0,
                                )))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  widget.language.total,
                                  textScaleFactor: 1.0,
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  ' \$' +
                                      paymentObj['total_payment'].toString(),
                                  textScaleFactor: 1.0,
                                )))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Future<bool> _onBackPressed() {
    cancelTimer();
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => pigAboo(),
        ));
  }

  LoadData() async {
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
//      debugPrint(response.body, wrapWidth: 1024);
    });
  }

  trackMyOrder() async {
    prefs = await SharedPreferences.getInstance();
    print('inDelliver');
//    print(widget.order_code);
//    print(prefs.getString('customerId'));
    await http
        .post('https://api.pigaboo.me/getOrderByCode',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'orderCode': widget.order_code,
              'customerId': prefs.getString('customerId'),
            }))
        .then((response) {
//      print(response.statusCode);
      Map<String, dynamic> responseJson = json.decode(response.body);
//      print(responseJson['order_status']);
//      debugPrint(response.body, wrapWidth: 1024);
      setState(() {
        paymentObj = {
          'food_fee': responseJson['food_fee'],
          'delivery_fee': responseJson['delivery_fee'],
          'total_payment': responseJson['total_payment']
        };
        menu_list = json.decode(responseJson['menu_list']);
      });

      debugPrint(menu_list.toString(), wrapWidth: 1024);
      print(menu_list.runtimeType);
      setState(() {
        isLoad = false;
      });
      startTimer();
    });
  }

  startTimer() {
    this.timers = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await http
          .post('https://api.pigaboo.me/getOrderByCode',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'orderCode': widget.order_code,
                'customerId': prefs.getString('customerId'),
              }))
          .then((response) {
        print(response.statusCode);
        Map<String, dynamic> responseJson = json.decode(response.body);
        print(responseJson['order_status']);
        if (this.mounted)
          setState(() {
            if (responseJson['order_status'] == 0) {
              calcuper = 0.0;
            } else if (responseJson['order_status'] == 1 ||
                responseJson['order_status'] == 2) {
              calcuper = 0.33;
            } else if (responseJson['order_status'] == 3) {
              calcuper = 0.66;
            } else if (responseJson['order_status'] == 4) {
              calcuper = 1.0;
              timer.cancel();
            }
          });
      });
    });
  }
  hexColor(String hexcolorcode) {
    String colornew = '0xff' + hexcolorcode;
    int colorint = int.parse(colornew);
    return colorint;
  }
  cancelTimer() {
    this.timers.cancel();
  }
}
