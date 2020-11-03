
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String image_name;
  TextEditingController user_name = TextEditingController();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();
  TextEditingController user_telphone = TextEditingController();
  TextEditingController user_facebook = TextEditingController();
  TextEditingController user_line = TextEditingController();
  File _image;
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
       image_name = (await firebaseStorageRef.getDownloadURL()).toString();
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }
    
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future<void> addUser() {
      String name=user_name.text.trim();
      String email=user_email.text.trim();
      String userpassword=user_password.text.trim();
      String facebook=user_facebook.text.trim();
      String line=user_line.text.trim();
      String telphone=user_telphone.text.trim();

      CollectionReference users = FirebaseFirestore.instance.collection('user');
      // Call the user's CollectionReference to add a new user
      uploadPic(context);
      return  users
          .add({
            'user_name': name, // 
            'user_detial':email, // 
            'user_of_user': userpassword, // 
            'user_facebook':facebook,
            'user_line':line,
            'user_telphone':telphone,
            'user_image':image_name,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    leading: IconButton(
                        icon: const Icon(Icons.home), onPressed: () {  },
                    ),
                    title: Text('บัญชี',textAlign: TextAlign.center),
                    
                  ),
                  body: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(children: <Widget>[
                      Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: (_image!=null)?Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 150.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        size: 30.0,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                            height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: user_name,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'ชื่อ',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: user_email,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'อีเมล',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: user_password,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'รหัส',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                              child: TextField(
                                controller: user_telphone,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'เบอร์โทรติดต่อ',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                        
                              child: TextField(
                                controller: user_facebook,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'facebook',
                                ),
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                        
                              child: TextField(
                                controller: user_line,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: 'Line',
                                ),
                              ),
                        ),
                        
                        SizedBox(
                            height: 10.0,
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

}