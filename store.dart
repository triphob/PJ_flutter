import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:projectlogin/home.dart';
import 'package:projectlogin/product_show.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  File _image;
  String image_name;
  String urlPicture;
  String downloadURL;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
  TextEditingController shop_name = TextEditingController();
  TextEditingController shop_detial = TextEditingController();
  TextEditingController shop_of_user = TextEditingController();
  TextEditingController shop_facebook = TextEditingController();
  TextEditingController shop_line = TextEditingController();
  TextEditingController shop_telphone = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => Store(),
      ),
    );
  }
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }
    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      this.image_name=fileName;
      firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
       firebase_storage.Reference firebaseStorageRef = storage.ref().child(fileName);
       firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_image);
       firebase_storage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete(() => null);
       downloadURL = (await firebaseStorageRef.getDownloadURL()).toString();
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }
    Future<void> addUser() {
      String name=shop_name.text.trim();
      String detial=shop_detial.text.trim();
      String of_user=shop_of_user.text.trim();
      String facebook=shop_facebook.text.trim();
      String line=shop_line.text.trim();
      String telphone=shop_telphone.text.trim();

      CollectionReference users = FirebaseFirestore.instance.collection('shop');
      // Call the user's CollectionReference to add a new user
      uploadPic(context);
      _reset();
      return  users
          .add({
            'shop_name': name, // 
            'shop_detial': detial, // 
            'shop_of_user': of_user, // 
            'shop_facebook':facebook,
            'shop_line':line,
            'shop_telphone':telphone,
            'shop_image':downloadURL,
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
                    title: Text('หน้าร้าน',textAlign: TextAlign.center),
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
                                controller: shop_name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ชื่อร้าน',
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
                                controller: shop_detial,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'รายเอียดของร้าน',
                                ),
                              ),
                        ),
                        SizedBox(
                            height: 10.0,
                        ),
                        Container(
                  
                    child: Row(
                      
                  children: <Widget>[
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
                ),
                Container(
                          padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: shop_of_user,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'ชื่อเจ้าของ',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: shop_facebook,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'facebook',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: shop_line,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'Line',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: shop_telphone,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'เบอร์ร้าน',
                                ),
                              ),
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
                        MaterialPageRoute materialPageRoute =
                        MaterialPageRoute(builder: (BuildContext context) =>  Product_show());
                        Navigator.of(context).pushAndRemoveUntil(
                        materialPageRoute, (Route<dynamic> route) => false);
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

