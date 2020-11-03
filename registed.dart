import 'package:projectlogin/store.dart';

import 'loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'collectionfunction.dart';

class RegiterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<RegiterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController cpassword = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create new User',
            style: TextStyle(color: Color(0xFFF7F7F7)),
          ),
          backgroundColor: Colors.blue[800],
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                buildButtonlogin('Registed'),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Please put your Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Please put password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: cpassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Please put password again',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Confirm'),
                      onPressed: () {
                        signUp();
                      },
                    )),
                Container(
                  
                    child: Row(
                      
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        cancel();
                      },
                      
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
                ),
              ],
            )));
  }

  cancel() {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => LoginPage());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  signUp() {
    String _username = username.text.trim();
    String _password = password.text.trim();
    String confirmPassword = cpassword.text.trim();
    if (_password == confirmPassword && _password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: _username, password: _password)
          .then((user) {
        print("Sign up user successful.");
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Store());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      }).catchError((error) {
        print(error.message);
      });
    } else {
      _showMyDialog();
      print("Password and Confirm-password is not match.");
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('password not common'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                cpassword.text = "";
                password.text = "";
              },
            ),
          ],
        );
      },
    );
  }
}