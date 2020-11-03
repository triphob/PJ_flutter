import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'loginpage.dart';
import 'package:flutter/services.dart';
import 'teststorage.dart';

class Addproduct extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Addproduct> {
  File _image;
  String image_name;
  String downloadURL;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
  TextEditingController product_name = TextEditingController();
  TextEditingController product_detial = TextEditingController();
  TextEditingController product_price = TextEditingController();
  TextEditingController product_all = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }
    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
       firebase_storage.Reference firebaseStorageRef = storage.ref().child(fileName);
       firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_image);
       firebase_storage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete(() => null);
       downloadURL = (await firebaseStorageRef.getDownloadURL()).toString();
       print(downloadURL);
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }
    void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => Addproduct(),
      ),
    );
  }
    Future<void> addUser() {
      String name=product_name.text.trim();
      String detial=product_detial.text.trim();
      int price=int.parse(product_price.text.toString());
      int product_allp=int.parse(product_all.text.toString());
      CollectionReference users = FirebaseFirestore.instance.collection('product');
      // Call the user's CollectionReference to add a new user
      uploadPic(context);
      //_reset();
      return  users
          .add({
            'product_name': name, // 
            'product_detial': detial, // 
            'product_price': price, // 
            'product_all':product_allp ,
            'product_image':downloadURL,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    var _isEditiable;
        var _noteControllor;
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    leading: IconButton(
                        icon: const Icon(Icons.home), onPressed: () {  },
                    ),
                    title: Text('หน้าเพิ่มสินค้า',textAlign: TextAlign.center),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.menu),
                        tooltip: 'Show Snackbar',
                        onPressed: () {
                          scaffoldKey.currentState.showSnackBar(snackBar);
                        },
                      ),
                    ],
                  ),
                  body:Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                         Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: product_name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'กรุณาใส่ชื่อสินค้า',
                                ),
                              ),
                        ),
                        SizedBox(
                            height: 10.0,
                        ),
                        Container(
                          child: SizedBox(
                                      width: 150,
                                      height: 150.0,
                                      child: (_image!=null)?Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      ):Image.network(
                                        "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                          height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 8,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Padding(
                                padding: EdgeInsets.only(left: 320),
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                maxLines: 3,
                                controller: product_detial,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'รายละสินค้า',
                                ),
                              ),
                        ),
                        SizedBox(
                            height: 10.0,
                        ),
                        Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                              keyboardType: TextInputType.number,
                                controller: product_price,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ราคา',
                                ),
                              ),
                        ),
                        Container(
                          width: 20,
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                controller: product_all,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'จำนวน',
                                ),
                              ),
                        ),
                        Container(
                  
                    child: Row(
                      
                  children: <Widget>[
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
                ),
                Container(
                  
                    child: Row(
                      
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        'ยืนยัน',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        addUser();
                      },
                    ),
                    SizedBox(
                            width: 50
                        ),
                    FlatButton(
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      child: Text(
                        'ยกเลิก',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
                ),
          ],
        ),
      ),
    );
  }
  void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Next page'),
        ),
        body: const Center(
          child: Text(
            'This is the next page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}
}
class AddUser {
  final String name;
  final String detial;
  final int price;
  final int product_allp;

  AddUser(this.name, this.detial, this.price, this.product_allp){
    addUser();
  }

  @override
 
    // Create a CollectionReference called users that references the firestore collection
    Future<void> addUser() {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'product_name': name, // 
            'product_detial': detial, // 
            'product_price': price, // 
            'product_all':product_allp
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  
}