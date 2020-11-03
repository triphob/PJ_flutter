import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'Addproduct.dart';
import 'account.dart';
import 'store.dart';
import 'product_show.dart';
import 'loginpage.dart';
import 'teststorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: LoginPage(),);
  }
}
