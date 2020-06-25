import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigaboo/model/Login.dart';
import 'package:pigaboo/model/MerchantAllMenuList.dart';
import 'package:pigaboo/model/Merchantdata.dart';
import 'package:pigaboo/model/Merchantpayment.dart';
import 'package:pigaboo/model/Merchanttheme.dart';
import 'package:pigaboo/model/Pasa.dart';
import 'package:pigaboo/model/constanc.dart';
import 'package:pigaboo/page/DeliveryDetail.dart';
import 'package:pigaboo/page/cart.dart';
import 'package:pigaboo/page/login.dart';
import 'package:pigaboo/page/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class merchants extends StatefulWidget {
  Pasa language;
  Merchantdata merchantData;
  Merchanttheme merchantTheme;
  Merchantpayment merchantPayment;

  merchants(
      {this.language,
      this.merchantData,
      this.merchantTheme,
      this.merchantPayment});

  @override
  _merchantsState createState() => _merchantsState();
}

class _merchantsState extends State<merchants> {
  SharedPreferences prefs;
  bool getAllUserOrder = true;
  bool isLoadOrder = false;
  bool isLoadData = true;
  bool isLogin = false;
  int floatcount = 0;
  List countForItem = new List();
  List countForSelected = new List();
  List popular_Categories = new List();
  List subCategoties = new List();
  List promoted = new List();
  List avgPrice = new List();
  List allOrderedActiveList;
  List allOrderedHistoryList = new List();
  var objinmerchant;
  final _Scrollcontroller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(hexColor(widget.merchantTheme.mainColour)),
            title: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.merchantTheme.logoUrl),
                ),
                Expanded(
                  child: Container(
                    height: 10,
                  ),
                ),
                IconButton(
                  onPressed: () {
//                    _showAlertOrderCode();
//                    showGeneralDialog(
//                        context: context,
//                        pageBuilder: (context, animation1, animation2) {
//                          return MyDialog(widget.merchantData.alias);
//                        });
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widgets) {
                          final curvedValue =
                              Curves.easeInOutBack.transform(a1.value) - 1.0;
                          return Transform(
                            transform: Matrix4.translationValues(
                                0.0, curvedValue * 200, 0.0),
                            child: Opacity(
                              opacity: a1.value,
                              child: MyDialog(
                                  widget.merchantData.alias, widget.language,widget.merchantTheme),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 200),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {});
                  },
                  icon: Icon(Icons.description),
                ),
//                SizedBox(width: 10,),
                isLogin != false
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(prefs.getString('firstName'),
                                textScaleFactor: 1.0)))
                    : Container(
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                //Navigation
                                _navigateToLogin(context);
                              },
                              child: Container(
                                child: Text('Login /',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _navigateToRegister(context);
                              },
                              child: Container(
                                child: Text('Register',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          body: isLoadData
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            widget.merchantTheme.heroboxUrl,
//                            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSN3lPsPRhwrCLlWw9OizH4_pVebhxDIjrhszJ6feDV73fMxNXf&usqp=CAU',
                            fit: BoxFit.cover,
                            width: constanc.ScreenWidth,
                            height: constanc.ScreenHeight * 0.2,
                          ),
                          Divider(
                            color: Color(
                                hexColor(widget.merchantTheme.mainColour)),
                            height: 30,
                            indent: constanc.ScreenWidth / 2 - 50,
                            endIndent: constanc.ScreenWidth / 2 - 50,
                            thickness: 2,
                          ),
                          Center(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                child: Text('หมวดหมู่ยอดนิยม',
                                    textScaleFactor: 1.0)),
                          ),
                          Container(
                            //Top rate
                            //list card
                            width: constanc.ScreenWidth,
                            height: constanc.ScreenHeight * 0.3,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: popular_Categories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap:  (){_animateToIndex(index);
                                    print('tsppawe');},
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
                                      width: constanc.ScreenWidth / 3,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: constanc.ScreenWidth / 3 - 50,
                                            height: constanc.ScreenWidth / 3 - 50,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      subCategoties[index][0]
                                                          ['img_url']),
//                                                image: NetworkImage(
//                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSN3lPsPRhwrCLlWw9OizH4_pVebhxDIjrhszJ6feDV73fMxNXf&usqp=CAU'),
                                                )),
//                                      ),
                                          ),
                                          Text(
                                            popular_Categories[index].toString(),
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'ราคาโดยประมาณ ฿' +
                                                avgPrice[index].toString(),
                                            textScaleFactor: 1.0,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          //Top rate
                          Divider(
                            height: 12,
                            thickness: 10,
                            color: Color(
                                hexColor(widget.merchantTheme.mainColour)),
                          ),
                          Container(
                            width: constanc.ScreenWidth,
                            color: Colors.white,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Divider(
                                    height: 20,
                                    color: Color(hexColor(
                                        widget.merchantTheme.mainColour)),
                                    thickness: 2,
                                    endIndent: (constanc.ScreenWidth / 4) * 3,
                                  ),
                                  Text(
                                    widget.language.Recommended,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(widget.language.Recommended_desc,
                                      textScaleFactor: 1.0),
                                  Container(
                                    width: constanc.ScreenWidth,
                                    height: constanc.ScreenHeight * 0.2,
                                    child: ListView.builder(
                                        //promoted
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: promoted.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            width: 200,
                                            height: 100,
                                            margin: EdgeInsets.all(10),
                                            child: Stack(
                                              children: <Widget>[
//                                                Image.network(
//                                                  'https://6.viki.io/image/43caa85b2af94eb198f0050e9a1a857c.jpeg?s=900x600&e=t',
                                                Image.network(
                                                  promoted[index]['img_url'],
                                                  fit: BoxFit.cover,
                                                  width: 200,
                                                  height: 100,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                        color: Colors.black,
                                                        child: Text(
                                                          promoted[index]
                                                              ['category_type'],
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                    Expanded(
                                                      child: Container(
                                                        height: 10,
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Colors.deepOrange,
                                                      child: Text(
                                                        widget.language.hot,
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  //recomment
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Image.network(widget.merchantTheme.promoUrl,
//                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSN3lPsPRhwrCLlWw9OizH4_pVebhxDIjrhszJ6feDV73fMxNXf&usqp=CAU',
                                      fit: BoxFit.cover,
                                      width: constanc.ScreenWidth,
                                      height: constanc.ScreenWidth,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: constanc.ScreenWidth,
                                      height: constanc.ScreenWidth,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      ),
                                    );
                                  }),
                                  //listtest
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: popular_Categories == null
                                        ? 0
                                        : popular_Categories.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: Column(
                                          children: <Widget>[
                                            Divider(
                                              height: 50,
                                              color: Color(hexColor(widget
                                                  .merchantTheme.mainColour)),
                                              thickness: 2,
                                              endIndent:
                                                  (constanc.ScreenWidth / 4) *
                                                      3,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  width:constanc.ScreenWidth,
                                                  child: Text(
                                                    popular_Categories[index]
                                                        .toString(),
                                                    textScaleFactor: 1.0,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    controller: _Scrollcontroller,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: subCategoties ==
                                                            null
                                                        ? 0
                                                        : subCategoties[index]
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index2) {
                                                      return Card(//fix this
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              child:
                                                                  Image.network(
                                                                subCategoties[
                                                                            index]
                                                                        [index2]
                                                                    ['img_url'],
//                                                                'https://f.ptcdn.info/963/022/000/1409582663-01-o.jpg',
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 150,
                                                                height: 100,
                                                                loadingBuilder: (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent
                                                                        loadingProgress) {
                                                                  if (loadingProgress ==
                                                                      null)
                                                                    return child;
                                                                  return Container(
                                                                    width: 150,
                                                                    height: 100,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        value: loadingProgress.expectedTotalBytes !=
                                                                                null
                                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                                loadingProgress.expectedTotalBytes
                                                                            : null,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                        flex:5,
                                                                        child: Container(
                                                                          width: constanc.ScreenWidth,
                                                                          height: 25,
                                                                          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                                                          child: Text(
                                                                            subCategoties[index][index2]
                                                                                    [
                                                                                    'menu_name']
                                                                                .toString(),style: TextStyle(fontSize: 10),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                      ),
//                                                                      Expanded(
//                                                                        child:
//                                                                            Container(
//                                                                          height:
//                                                                              5,
//                                                                        ),
//                                                                      ),
                                                                      Expanded(
                                                                        flex:1,
                                                                        child: Container(
                                                                          width: constanc.ScreenWidth,
                                                                          height: 25,
                                                                          margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                                                                          child: Text(
                                                                            subCategoties[index][index2]
                                                                                    [
                                                                                    'price']
                                                                                .toString(),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    10),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(children: <Widget>[
                                                                    Expanded(child: Container(
                                                                      height: 10,),),
                                                                    Container(
                                                                      margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                        BorderRadius.circular(5),
                                                                        color: countForItem[index][index2]['count'] == 0
                                                                        ? null
                                                                        : Colors.red,
                                                                      ),
                                                                    width: 20,
                                                                    height: 20,
                                                                        child: countForItem[index][index2]['count'] == 0
                                                                      ? null
                                                                      : Center(
                                                                          child:
                                                                              Text(countForItem[index][index2]['count'].toString(),
                                                                          textScaleFactor: 1.0,
                                                                          style: TextStyle(color: Colors.white),
                                                                        )),
                                                                    ),
                                                                    subCategoties[index][index2]['isAvailable'] == '0'
                                                                    ? Container(
                                                                        margin: EdgeInsets.fromLTRB(0, 30, 20, 0),
                                                                        child: Text('out of stock', textScaleFactor: 1.0),
                                                                    )
                                                                    : GestureDetector(
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            color: Colors.amber,
                                                                          ),
                                                                          margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                                                                          width: 20,
                                                                          height: 20,
                                                                          child: Icon(Icons.add,size: 20,),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          _showModalBottomSheet(
                                                                              context,
                                                                              subCategoties[index][index2],
                                                                              index,
                                                                              index2);
                                                                        },
                                                                      ),
                                                                  ],),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          floatingActionButton: Opacity(
            opacity: 0.85,
            child: Stack(
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor:
                      Color(hexColor(widget.merchantTheme.mainColour)),
                  child: Icon(Icons.shopping_cart),
                  onPressed: () {
                    _navigatorToCart();
                  },
                ),
                floatcount == 0
                    ? Text('')
                    : Positioned(
                        right: 0,
                        top: -10,
                        child: Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.red,
                            child: Text(
                              floatcount.toString(),
                              style: TextStyle(color: Colors.white),
                            ))),
              ],
              overflow: Overflow.visible,
            ),
          )),
    );
  }
  _animateToIndex(i) => _Scrollcontroller.animateTo(100.00 * i, duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  _navigatorToCart() async {
    print('userSended');
    print(widget.merchantData.alias);
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => cart(
                language: widget.language,
                countForSelected: countForSelected,
                shopAlias: widget.merchantData.alias))).then((value) {
      setState(() {
        countForSelected = value;
        for (int i = 0; i < countForItem.length; i++) {
          for (int j = 0; j < countForItem[i].length; j++) {
            countForItem[i][j]['count'] = 0;
          }
        }
        floatcount = 0;
        for (int i = 0; i < countForItem.length; i++) {
          for (int j = 0; j < countForItem[i].length; j++) {
            for (int k = 0; k < countForSelected.length; k++)
              if (countForItem[i][j]['menu_id'] == value[k]['menu_id']) {
                countForItem[i][j]['count'] += value[k]['count'];
                floatcount += value[k]['count'];
              }
          }
        }
        print('eeljsdf' + value.toString());
      });
    });
  }

  _navigateToLogin(BuildContext context) async {
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
      });
    });
    if (checklogin != null) {
      getUserData();
      setState(() {
        isLogin = prefs.getBool('status');
      });
    }
  }

  _navigateToRegister(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Login checklogin = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => register(language: widget.language)));
    if (checklogin != null) {
      setState(() {});
    }
  }

  hexColor(String hexcolorcode) {
    String colornew = '0xff' + hexcolorcode;
    int colorint = int.parse(colornew);
    return colorint;
  }

  Future LoadData() async {
    await http
        .post('https://api.pigaboo.me/getAllMenuList',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'shopAlias': widget.merchantData.alias,
            }))
        .then((response) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      debugPrint(response.body, wrapWidth: 1024);

      List<dynamic> data = responseJson["detail"];
      print('-------------------------');
      objinmerchant = listCategoryObj(data, 'category_type');
      objinmerchant.forEach((k, v) {
//        print('Key=$k, Value=$v');
        popular_Categories.add(k);
        subCategoties.add(v);
      });
      for (int i = 0; i < popular_Categories.length; i++) {
        countForItem.add([]);
        for (int j = 0; j < subCategoties[i].length; j++) {
          if (subCategoties[i][j]['isPromoted'].toString() == '1') {
            promoted.add(subCategoties[i][j]);
          }
          countForItem[i]
              .add({'menu_id': subCategoties[i][j]['menu_id'], 'count': 0});
        }
      }
//      final prettyString = JsonEncoder.withIndent('  ').convert(response.body);
//      debugPrint(prettyString);
      for (int i = 0, sum = 0; i < popular_Categories.length; i++) {
        for (int j = 0; j < subCategoties[i].length; j++) {
          sum += subCategoties[i][j]['price'];
        }
        avgPrice.add((sum / subCategoties[i].length).floor());
        sum = 0;
      }

      return data.map((m) => new MerchantAllMenuList.fromJson(m)).toList();
    });
    setState(() {
      isLoadData = false;
    });
  }

  listCategoryObj(arrObj, String property) {
    var obj = {};
    for (int i = 0; i < arrObj.length; i++) {
      if (!obj.containsKey(arrObj[i][property])) {
        obj[arrObj[i][property]] = [];
      }
      obj[arrObj[i][property]].add(arrObj[i]);
    }

    final prettyString = JsonEncoder.withIndent('  ').convert(obj);

//    debugPrint(prettyString);
    return obj;
  }

  addCartItem(var _item) {
    bool added = false;
    if (countForSelected.length == 0) {
      countForSelected.add(_item);
      added = true;
    } else {
      for (int i = 0; i < countForSelected.length; i++) {
        if (countForSelected[i]['menu_id'] == _item['menu_id'] &&
            thatEqual(countForSelected[i]['addon'], _item['addon'])) {
          countForSelected[i]['count'] += _item['count'];
          added = true;
          break;
        }
      }
    }
    if (!added) {
      countForSelected.add(_item);
    }
    print('cartItem');
    print('countForSelected');
    print(countForSelected);
  }

  bool thatEqual(_countForSelectedaddon, _itemaddon) {
    print(_countForSelectedaddon);
    print(_itemaddon);
    for (int i = 0; i < _countForSelectedaddon.length; i++) {
      for (int j = 0; j < _itemaddon.length; j++) {
        if (_countForSelectedaddon[i]['name'] == _itemaddon[j]['name']) {
          return true;
        }
      }
    }
    return false;
  }

  _showModalBottomSheet(context, _menuList, index1, index2) {
    var addon;
    int menuPrice = _menuList['price'];
    int totalPrice = _menuList['price'];
    int addontotalPrice = 0;
    List addonselected = new List();
    int count = 1;
    List<bool> checkis = new List();
    List<int> addonPrice = new List();
    var objItem = {};
    if (_menuList['addon'] != 'NO_ADDON') {
      addon = json.decode(_menuList['addon']);
      for (int i = 0; i < addon.length; i++) {
        checkis.add(false);
        addonPrice.add(int.parse(addon[i]['price'].toString()));
      }
//      print(addon);
//      print(addonPrice[0].runtimeType);
    } else {}
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                  height: constanc.ScreenHeight * 0.65,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: constanc.ScreenWidth,
                        color: Colors.black12,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    _menuList['menu_name'],
                                    textScaleFactor: 1.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 10,
                                    ),
                                  ),
                                  Text(_menuList['price'].toString(),
                                      textScaleFactor: 1.0),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
//                                      color: Colors.red,
                                      margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                      child: Text(
                                        '    ' + _menuList['description'],
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: addon == null
                              ? null
                              : ListView.builder(
                                  itemCount: addon.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(5, 5, 20, 5),
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                            value: checkis[index],
                                            onChanged: (bool value) {
                                              setState(() {
                                                if (value) {
                                                  addontotalPrice =
                                                      addonPrice[index] * count;
                                                  totalPrice += addontotalPrice;
                                                  print('inbox' +
                                                      addontotalPrice
                                                          .toString());
                                                  addonselected
                                                      .add(addon[index]);
                                                } else {
                                                  totalPrice -= addontotalPrice;
                                                  addontotalPrice = 0;
                                                  print('inbox' +
                                                      addontotalPrice
                                                          .toString());
                                                  addonselected
                                                      .remove(addon[index]);
                                                }
                                                checkis[index] = value;
                                              });
                                            },
                                          ),
                                          Text(addon[index]['name'],
                                              textScaleFactor: 1.0),
                                          Expanded(
                                            child: Container(
                                              height: 10,
                                            ),
                                          ),
                                          Text(addon[index]['price'].toString(),
                                              textScaleFactor: 1.0),
                                        ],
                                      ),
                                    );
                                  }),
                        ),
                      ),
                      Container(
                        height: constanc.ScreenHeight * 0.07,
                        width: constanc.ScreenWidth,
                        child: Center(
                            child: Text(totalPrice.toString(),
                                textScaleFactor: 1.0)),
                      ),
                      Container(
                        width: constanc.ScreenWidth,
                        height: constanc.ScreenHeight * 0.075,
                        color: Colors.white70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CupertinoButton(
                              onPressed: () {
                                if (count > 1)
                                  setState(() {
                                    totalPrice -= menuPrice;
                                    for (int i = 0;
                                        i < addonPrice.length;
                                        i++) {
                                      if (checkis[i]) {
                                        totalPrice -= addonPrice[i];
                                        addontotalPrice -= addonPrice[i];
                                      }
                                    }
                                    count--;
                                    print(addontotalPrice);
                                  });
                              },
                              child: Icon(Icons.remove),
                            ),
                            SizedBox(
                              width: constanc.ScreenWidth / 6,
                              child: Container(
                                child: Center(
                                    child: Text(
                                  count.toString(),
                                  textScaleFactor: 1.0,
                                  style: TextStyle(fontSize: 20),
                                )),
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  totalPrice += menuPrice;
                                  print(addontotalPrice);
                                  for (int i = 0; i < addonPrice.length; i++) {
                                    if (checkis[i]) {
                                      totalPrice += addonPrice[i];
                                      addontotalPrice += addonPrice[i];
                                    }
                                  }
                                  count++;
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          objItem = {
                            'menu_name': subCategoties[index1][index2]
                                ['menu_name'],
                            'menu_id': subCategoties[index1][index2]['menu_id'],
                            'price': subCategoties[index1][index2]['price'],
                            'count': count,
                            'addon': addonselected.isEmpty
                                ? [
                                    {'name': 'NO_ADDON', 'price': 0}
                                  ]
                                : addonselected
                          };
                          addCartItem(objItem);
                          Navigator.pop(context);
                          this.setState(() {
                            countForItem[index1][index2]['count'] += count;
                            floatcount += count;
                          });
                        },
                        child: Container(
                          color: Colors.black87,
                          height: constanc.ScreenHeight * 0.1,
                          width: constanc.ScreenWidth,
                          child: Center(
                              child: Text(
                            'Add to cart',
                            textScaleFactor: 1.0,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Widget rederItem(List item) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text('' + index.toString(), textScaleFactor: 1.0),
              ],
            ),
          );
        });
  }

  getUserData() async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    if (prefs.getBool('status') != null) {
      setState(() {
        isLogin = prefs.getBool('status');
      });
    }
  }
}

class MyDialog extends StatefulWidget {
  String alias;
  Pasa language;
  Merchanttheme theme;
  MyDialog(this.alias, this.language,this.theme);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Color _c = Colors.redAccent;
  List allOrderedActiveList = new List();
  List allOrderedHistoryList = new List();
  bool getAllUserOrder = true;
  bool isLoadOrder = true;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoadOrder = true;
    _getAllUserOrdersActive();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Row(
        children: <Widget>[
          RaisedButton(
            color: getAllUserOrder?Color(hexColor(widget.theme.mainColour)):null,
            onPressed: (){
              setState(() {
                isLoadOrder = true;
                getAllUserOrder = true;
              });
              _getAllUserOrdersActive();
            },
            child: Row(
              children: <Widget>[
            Icon(Icons.local_shipping),
              SizedBox(width: 10,),
              Text('Active'),
          ],),),

          Expanded(
            child: Container(
              height: 2,
            ),
          ),
          RaisedButton(
            color: getAllUserOrder?null:Color(hexColor(widget.theme.mainColour)),
            onPressed: (){
              setState(() {
                isLoadOrder = true;
                getAllUserOrder = false;
              });
              _getAllUserOrdersHistory();
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.history),
                SizedBox(width: 10,),
                Text('History'),
              ],),),

        ],
      ),
      content: Container(
        width: constanc.ScreenWidth,
        height: constanc.ScreenHeight / 3,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[],
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color:  Color(hexColor(widget.theme.mainColour)),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Text(
                        this.widget.language.time,
                        textAlign: TextAlign.left,
                      ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Text(
                        this.widget.language.price,
                        textAlign: TextAlign.center,
                      ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Text(
                        this.widget.language.status,
                        textAlign: TextAlign.right,
                      ))),
                ],
              ),
            ),
            Expanded(
//                        child: Container(child: Center(child:  CircularProgressIndicator(),),),
                child: isLoadOrder == true
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: getAllUserOrder == true
                            ? allOrderedActiveList.length
                            : allOrderedHistoryList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(height: 15, color: Colors.black54),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              print(allOrderedActiveList[index]['order_code']
                                  .toString());
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => DeliveryDetail(
                                            language: widget.language,
                                            order_code:
                                                allOrderedActiveList[index]
                                                    ['order_code'],
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10 , 0, 10, 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text(
                                          getAllUserOrder == true
                                              ? allOrderedActiveList[index]
                                                      ['timestamp']
                                                  .toString()
                                              : allOrderedHistoryList[index]
                                                      ['timestamp']
                                                  .toString(),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text(
                                          getAllUserOrder == true
                                              ? allOrderedActiveList[index]
                                                      ['total_payment']
                                                  .toString()
                                              : allOrderedHistoryList[index]
                                                      ['total_payment']
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text(
                                          getAllUserOrder == true
                                              ? allOrderedActiveList[index]
                                                      ['order_status']
                                                  .toString()
                                              : allOrderedHistoryList[index]
                                                      ['order_status']
                                                  .toString(),
                                          textAlign: TextAlign.right,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        })),
          ],
        ),
      ),
    );
  }

  _getAllUserOrdersActive() async {
    prefs = await SharedPreferences.getInstance();
    await http
        .post('https://api.pigaboo.me/getAllUserOrdersActive',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'customerId': prefs.getString('customerId'),
            }))
        .then((response) {
      print(response.statusCode);
      for (int i = 0; i < json.decode(response.body).length; i++) {
        if (json.decode(response.body)[i]['shop_alias'] == widget.alias) {
          allOrderedActiveList.add(json.decode(response.body)[i]);
        }
      }
      print(allOrderedActiveList.toString());
      print('in active');
      setState(() {
        isLoadOrder = false;
      });
    });
  }

  void _getAllUserOrdersHistory() async {
    await http
        .post('https://api.pigaboo.me/getAllUserOrdersHistory',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'customerId': prefs.getString('customerId'),
            }))
        .then((response) {
      print(response.statusCode);
      setState(() {
        allOrderedHistoryList = json.decode(response.body);
        debugPrint(allOrderedHistoryList.toString(), wrapWidth: 1024);
      });
      print('in history');
      setState(() {
        isLoadOrder = false;
      });
    });
  }
  hexColor(String hexcolorcode) {
    String colornew = '0xff' + hexcolorcode;
    int colorint = int.parse(colornew);
    return colorint;
  }
}
