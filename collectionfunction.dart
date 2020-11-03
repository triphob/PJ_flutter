  import 'package:flutter/material.dart';

Container buildButtonlogin(var textinput) {
    return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(10),
    child: Text(
      textinput,
      style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
          fontSize: 30),
    ));
  }
