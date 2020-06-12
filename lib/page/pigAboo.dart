import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:pigaboo/model/Login.dart';
import 'package:pigaboo/model/Menu.dart';
import 'package:pigaboo/model/Merchantdata.dart';
import 'package:pigaboo/model/Merchantpayment.dart';
import 'package:pigaboo/model/Merchanttheme.dart';
import 'package:pigaboo/model/Pasa.dart';
import 'package:pigaboo/model/constanc.dart';
import 'package:pigaboo/page/login.dart';
import 'package:pigaboo/page/merchants.dart';
import 'package:pigaboo/page/profile.dart';
import 'package:pigaboo/page/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pigAboo extends StatefulWidget {
  static String imagep =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSN3lPsPRhwrCLlWw9OizH4_pVebhxDIjrhszJ6feDV73fMxNXf&usqp=CAU';
  Login userData;

  pigAboo({this.userData});

  @override
  _pigAbooState createState() => _pigAbooState();
}

class _pigAbooState extends State<pigAboo> {
  String dropdownValue = 'ภาษาไทย';
  Pasa language = Pasa();
  bool isLogin = false;
  Login userData;
  bool isLoad = false;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    isLoad = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    constanc.ScreenWidth = MediaQuery.of(context).size.width;
    constanc.ScreenHeight = MediaQuery.of(context).size.height;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoad
        ? Scaffold(
            body: Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(255, 176, 3, 1),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                      height: constanc.ScreenHeight*0.03,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValue,
//                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              language.setPasa(newValue);
                            });
                          },
                          items: <String>['ภาษาไทย', 'English', ' 简体中文']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,textScaleFactor: 1.0),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Image.asset(
                      'images/Logo_black.png',
//                      scale: 8,
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'PIG A BOO',textScaleFactor: 1.0,
                          style: TextStyle(fontSize: constanc.ScreenWidth*0.05),
                        ),
                        Text(
                          language.fromdoortodoor,textScaleFactor: 1.0,
//                          style: TextStyle(fontSize: 15),
                        style: TextStyle(fontSize: constanc.ScreenWidth*0.04),
                        ),
                      ],
                    ),
                  ),
                    isLogin != false?
                      Flexible(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        proflie(language: language)));
                          },
                          child: Container(
                              child: prefs.getString('firstName') != null
                                  ? Container(
//                                    width:
//                                        MediaQuery.of(context).size.width * 0.2,
                                      child: Text(prefs.getString('firstName'),textScaleFactor: 1.0))
                                  : null),
                        ),
                      )
                     : Flexible(
                      flex: 2,
                       child: Container(
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  //Navigation
                                  _navigateToLogin(context);
                                },
                                child: Container(
                                  child: Text('Login /',
                                      style: TextStyle(fontSize: 10),textScaleFactor: 1.0),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _navigateToRegister(context);
                                  },
                                  child: Container(
                                    child: Text('Register',textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                     ),
                ],
              ),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //head_pic
                        width: constanc.ScreenWidth,
                        child: Image.network(
                          pigAboo.imagep,
                          fit: BoxFit.cover,
                          width: constanc.ScreenWidth,
                          height: 200,
                        ),
                      ), //head_pic
                      Container(
                        //Store
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: constanc.ScreenWidth,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Color.fromRGBO(242, 242, 242, 1),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage('images/Icon_cart.png'),
                                      backgroundColor: Colors.amber,
                                    ),
                                  ),
                                  Text(
                                    language.store,textScaleFactor: 1.0,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Color.fromRGBO(249, 218, 123, 1),
                              height: 0,
                              thickness: 5,
                            ),
                            Container(
                              // Restaurant_List Card
                              height: 400,
                              child: FutureBuilder<List<Menu>>(
                                future: fetchMenu(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Menu> menu = snapshot.data;
                                    return GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: menu.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: GestureDetector(
                                            child: Card(
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    width: 150,
                                                    child: Center(
                                                      child: Text(
                                                        menu[index].name,
                                                        overflow: TextOverflow
                                                            .ellipsis,textScaleFactor: 1.0,
                                                        textWidthBasis:
                                                            TextWidthBasis
                                                                .longestLine,
                                                      ),
                                                    ),
                                                  ),
                                                  Image.network(
//                                                   'https://f.ptcdn.info/963/022/000/1409582663-01-o.jpg',
                                                    menu[index].heroBox,
                                                    width: 150,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              _onCardTapped(menu[index].alias);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return Center(child: CircularProgressIndicator());
                                },
                              ),
                            ),
                          ],
                        ),
                      ), //Store
                      Container(
                        //Store
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                //head
                                color: Color.fromRGBO(242, 242, 242, 1),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage('images/Icon_howto.png'),
                                        backgroundColor: Colors.amber,
                                      ),
                                    ),
                                    Text(
                                      language.howtouse,textScaleFactor: 1.0,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ), //head
                              Divider(
                                color: Color.fromRGBO(249, 218, 123, 1),
                                height: 0,
                                thickness: 5,
                              ),
                              Container(
                                // Restaurant_List Card
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.search,
                                                  size: 70,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                          language.browse,textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                        language.browse_desc,textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 10,
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.fastfood,
                                                  size: 70,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                        language
                                                            .choosesyourdishes,textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                          language
                                                              .choosesyourdishes_desc,textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontSize: 10)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.monetization_on,
                                                  size: 70,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                          language
                                                              .confrimorderandpay,textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                        language
                                                            .confrimorderandpay_desc,textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 10,
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.home,
                                                  size: 70,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                          language
                                                              .deliveryorpickup,textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width) /
                                                          4,
                                                      child: Text(
                                                        language
                                                            .deliveryorpickup_desc,textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ), //how_to
                      Container(
                        //Join Us
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: constanc.ScreenWidth,
                        child: Container(
                          width: constanc.ScreenWidth,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage(
                                              'images/Icon_joinus.png'),
                                          backgroundColor: Colors.amber,
                                        ),
                                      ),
                                      Text(
                                        language.beourpartner,textScaleFactor: 1.0,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Color.fromRGBO(249, 218, 123, 1),
                                  height: 0,
                                  thickness: 5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  language.whyus,textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(language.whyus_desc,textScaleFactor: 1.0),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  language.increseslaes,textScaleFactor: 1.0,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(language.increseslaes_desc,textScaleFactor: 1.0),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  language.easytomanagethestore,textScaleFactor: 1.0,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(language.easytomanagethestore_desc,textScaleFactor: 1.0),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ), //Join Us
                      Container(
                        //About Us
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: constanc.ScreenWidth,
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Color.fromRGBO(242, 242, 242, 1),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage('images/Icon_pig.png'),
                                        backgroundColor: Colors.amber,
                                      ),
                                    ),
                                    Text(
                                      language.about + ' PIGABOO',textScaleFactor: 1.0,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color.fromRGBO(249, 218, 123, 1),
                                height: 0,
                                thickness: 5,
                              ),
                              Text(language.about_desc,textScaleFactor: 1.0),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ), //About Us
                      Container(
                        //tail
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: Color.fromRGBO(255, 176, 3, 1),
                        width: constanc.ScreenWidth,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset(
                                  'images/Logo_black.png',
                                  scale: 8,
                                ),
                                Text('LocalTeenranger',textScaleFactor: 1.0),
                                Text(
                                  '117/143 หมู่ที่ 12 ตำบลป่าแดด อำเภอเมือง จังหวัดเชียงใหม่ 50100',textScaleFactor: 1.0,
                                  style: TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                height: 10,
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/Line.png',
                                        scale: 2,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('@LTRcafe',textScaleFactor: 1.0,
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/Tel.png',
                                        scale: 2,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('098-6589999',textScaleFactor: 1.0,
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/Fb.png',
                                        scale: 2,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'LocalTeenranger',textScaleFactor: 1.0,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 10,
                              ),
                            ),
                          ],
                        ),
                      ), //tail
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  _navigateToLogin(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Login checklogin = await Navigator.push(context,
        // ignore: missing_return
        CupertinoPageRoute(builder: (context) => login(language: language))).then((value){
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
  getUserData() async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('firstName');
    print(stringValue);
    if(prefs.getBool('status')!=null) {
      setState(() {
        isLogin = prefs.getBool('status');
      });
    }
  }
  _navigateToRegister(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Login checklogin = await Navigator.push(context,
        CupertinoPageRoute(builder: (context) => register(language: language)));
    if (checklogin != null) {
      setState(() {
        isLogin = checklogin.status;
      });
    }
  }

  _onCardTapped(String alias) async {
    setState(() {
      isLoad = true;
    });
    await http
        .post('https://api.pigaboo.me/getSingleShop', headers: <String, String>{
//          'Content-Type': 'application/json; charset=UTF-8',
    }, body: {
      "shopAlias": alias,
    }).then((response) {
      if (response.statusCode == 200) {
//        debugPrint(response.body, wrapWidth: 1024);
        Map<String, dynamic> responseJson = json.decode(response.body);
        Merchantdata MerchantData = Merchantdata.fromJson(responseJson['data']);
        Merchanttheme MerchantTheme =
            Merchanttheme.fromJson(responseJson['theme']);
        print(responseJson['theme']);
        Merchantpayment MerchantPayment =
            Merchantpayment.fromJson(responseJson['payment']);
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => merchants(
                      language: language,
                      merchantData: MerchantData,
                      merchantTheme: MerchantTheme,
                      merchantPayment: MerchantPayment,
                    )));
      } else {
        throw Exception('error :(');
      }
      setState(() {
        isLoad = false;
      });
    });
  }

  Future<List<Menu>> fetchMenu() async {
    final response = await http.post('https://api.pigaboo.me/getAllShopsAlias',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          '': '',
        }));
    if (response.statusCode == 200) {
//    print('ResponseStatusCode: $logResponse'); // Check Status Code = 200
//    print('ResponseBody: ' + response.body); // Read Data in Array
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> data = responseJson["data"];
      return data.map((m) => new Menu.fromJson(m)).toList();
    } else {
      throw Exception('error :(');
    }
  }
}
