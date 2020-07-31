import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigaboo/model/Pasa.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class register extends StatefulWidget {
  Pasa language;
  String maincolor;
  String logo;
  String shopname;
  register({this.language, this.maincolor, this.logo, this.shopname});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool CheckFirstName = false;
    bool CheckLastName = false;
    bool CheckPhoneNumber = false;
    bool CheckPassword = false;
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  widget.language.register,textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        //userTextField
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: "firstName",
                          errorText: CheckFirstName
                              ? 'Firstname can\'t be empty'
                              : null,
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
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //userTextField
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: "lastName",
                          errorText: CheckLastName
                              ? 'Last name can\'t be empty'
                              : null,
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
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //userTextField
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: "phoneNumber",
                          errorText: CheckPhoneNumber
                              ? 'Phone number can\'t be empty'
                              : null,
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
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //userTextField
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "password",
                          errorText:
                              CheckPassword ? 'Password can\'t be empty' : null,
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
                    ],
                  ),
                ),
                CupertinoButton(
                  child: Text(widget.language.submit,textScaleFactor: 1.0),
                  color: Color(hexColor(widget.maincolor)),
                  onPressed: () {
                    setState(() {
                      firstNameController.text.isEmpty
                          ? CheckFirstName = true
                          : CheckFirstName = false;
                      lastNameController.text.isEmpty
                          ? CheckLastName = true
                          : CheckLastName = false;
                      phoneNumberController.text.isEmpty
                          ? CheckPhoneNumber = true
                          : CheckPhoneNumber = false;
                      passwordController.text.isEmpty
                          ? CheckPassword = true
                          : CheckPassword = false;
                    });
                    if (CheckFirstName) {
                      print('CheckFirstName');
                        // Alert FirstName empty
                        AlertDialog alert = AlertDialog(
                          title: Text("Firstname can\'t be empty",textScaleFactor: 1.0),
                          content: Text("Please fill firstname.",textScaleFactor: 1.0),
                        );
                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                    } else if (CheckLastName) {
                      print('CheckLastName');
                      // Alert LastName empty
                      AlertDialog alert = AlertDialog(
                        title: Text("Lastname can\'t be empty",textScaleFactor: 1.0),
                        content: Text("Please fill lastname.",textScaleFactor: 1.0),
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else if (CheckPhoneNumber) {
                      print('CheckPhoneNumber');
                      // Alert PhoneNumber empty
                      AlertDialog alert = AlertDialog(
                        title: Text("Phone number can\'t be empty",textScaleFactor: 1.0),
                        content: Text("Please fill phone number.",textScaleFactor: 1.0),
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else if (CheckPassword) {
                      print('CheckPassword');
                      // Alert Password empty
                      AlertDialog alert = AlertDialog(
                        title: Text("Password can\'t be empty",textScaleFactor: 1.0),
                        content: Text("Please fill password.",textScaleFactor: 1.0),
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else {
                      _Register(
                          firstNameController.text,
                          lastNameController.text,
                          phoneNumberController.text,
                          passwordController.text);
                      isLoading = true;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _Register(String firstName, String lastname, String phoneNumber,
      String password) async {
    String myURL = 'https://api.pigaboo.me/registerMember';
    http.post(myURL, headers: {}, body: {
      'firstName': firstName,
      'lastName': lastname,
      'password': password,
      'telephoneNumber': phoneNumber
    }).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        print(responseJson['status']);
//        setState(() {
        if(responseJson['status']) {
          _authenticate(phoneNumber, password);
        }else{
          AlertDialog alert = AlertDialog(
            title: Text("status false",textScaleFactor: 1.0),
            content: Text("try again",textScaleFactor: 1.0),
          );
          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        }
//        });
      } else {
        throw Exception('error :(');
      }
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        addStringToSF(responseJson);
      } else {
        throw Exception('error :(');
      }
    });
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
      Navigator.pop(context,true);
    });
  }
  hexColor(String hexcolorcode) {
    String colornew = '0xff' + hexcolorcode;
    int colorint = int.parse(colornew);
    return colorint;
  }
}
