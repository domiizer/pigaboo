import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:pigaboo/page/pigAboo.dart';
import 'package:http/http.dart' as http;
import 'package:pigaboo/scoped_model/login_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<loginmodel>(
      model: loginmodel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: pigAboo(),
          theme: ThemeData(
              primarySwatch: Colors.grey,
              primaryTextTheme:
                  TextTheme(title: TextStyle(color: Colors.black)))),
    );
  }
}
