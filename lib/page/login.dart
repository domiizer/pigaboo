import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigaboo/model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:pigaboo/model/Pasa.dart';
import 'package:pigaboo/page/pigAboo.dart';
import 'package:pigaboo/page/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pigaboo/scoped_model/login_model.dart';
import 'package:scoped_model/scoped_model.dart';

class login extends StatefulWidget {
  Pasa language;
  String maincolor;
  String logo;
  String shopname;

  login({this.language, this.maincolor, this.logo, this.shopname});

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(hexColor(widget.maincolor)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.logo),
            ),
            Expanded(
                child: Center(
                  child: Container(
                      child: Text(
              widget.shopname,
              textScaleFactor: 1.0,
            )),
                )),
          ],
        ),
      ),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 100, 50, 50),
                    child: TextFormField(
                      //phoneNumberTextField
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelText: "phoneNumber",
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Color(hexColor(widget.maincolor))),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Color(hexColor(widget.maincolor))),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 20),
                    child: TextFormField(
                      //passwordTextField
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(hexColor(widget.maincolor))),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Color(hexColor(widget.maincolor))),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ScopedModelDescendant<loginmodel>(
                        builder: (BuildContext context, Widget child,
                            loginmodel model) {
                          return FlatButton(
                            //Login Button
                            onPressed: () {
                              _authenticate(phoneNumberController.text,
                                  passwordController.text);
                              setState(() {
                                isLoading = true;
                              });
                            },
                            child: Text(
                              "Login",
                              textScaleFactor: 1.0,
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      ),
                      FlatButton(
                        //Register Button
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => register(language: widget.language,maincolor:widget.maincolor,logo:widget.logo,shopname:widget.shopname)));
                        },
                        child: Text(
                          "Register",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Color(hexColor(widget.maincolor)),
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: 20,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  addStringToSF(Map<String, dynamic> responseJson) async {
    print(responseJson);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', responseJson['status']);
    prefs.setString('firstName', responseJson['firstName']);
    prefs.setString('lastName', responseJson['lastName']);
    prefs.setString('phoneNumber', responseJson['phoneNumber']);
    prefs.setString('address', responseJson['address']);
    prefs.setString('address', responseJson['address']);
//    prefs.setString('address',"117/210 บ้านร้องเรือคํา ซอย 20 ตำบลป่าแดด อำเภอเมืองเชียงใหม่ เชียงใหม่ 50100 ประเทศไทย");
    prefs.setString('flag', responseJson['flag']);
    prefs.setString('customerId', responseJson['customerId']);
    print(prefs.getString('customerId'));
    setState(() {
      isLoading = false;
      Navigator.pop(context);
    });
  }

  _authenticate(String telephone, String password) async {
    String myURL = "https://api.pigaboo.me/loginMember";
    http.post(myURL, headers: {
//    'Accept': 'application/json'
    }, body: {
      "telephone": telephone,
      "password": password,
    }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        print(responseJson);
        addStringToSF(responseJson);
      } else {
        setState(() {
          isLoading = false;
        });
        AlertDialog alert = AlertDialog(
          title: Text("User does not exist", textScaleFactor: 1.0),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        throw Exception('error :(');
      }
    });
  }

  Future<bool> _onPop() {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => pigAboo(),
        ));
  }

  hexColor(String hexcolorcode) {
    String colornew = '0xff' + hexcolorcode;
    int colorint = int.parse(colornew);
    return colorint;
  }
}
