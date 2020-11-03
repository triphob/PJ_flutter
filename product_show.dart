
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectlogin/account.dart';
import 'package:projectlogin/product.dart';
import 'package:projectlogin/models/product_model.dart';
import 'package:projectlogin/store.dart';
import 'Addproduct.dart';

class Product_show extends StatefulWidget {
  @override
  _Product_show_state createState() => _Product_show_state();
}

class _Product_show_state extends State<Product_show> {
    @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('product');
    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  icon: const Icon(Icons.home), onPressed: () {  
                    
                  },
              ),
              title: Text('หน้าสินค้าทั้งหมด',textAlign: TextAlign.center),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  tooltip: 'account',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Account(),
                        ),
                      );
                  },
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  child:ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context,index) => product_num(
                    itemIndex: index,
                    product: products[index],
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                             product: products[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                 
                ),
                Container(
                  //color: Colors.pink,
                  margin: EdgeInsets.only(top:550),
                    child: Row(
                      
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      //color: Colors.blue,
                      child: Icon(Icons.add),
                      // child: Text(
                      //   'ยืนยัน',
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      onPressed: () {
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Store(),
                      //   ),
                      // );
                      },
                    ),
                    SizedBox(
                            width: 150
                        ),
                    FlatButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Icon(Icons.add),
                      // child: Text(
                      //   'ยกเลิก',
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Addproduct(),
                        ),
                      );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
                ),
              ],
            ),
    );
  }
}

class product_num extends StatelessWidget {
  

  const product_num({
    Key key,
    this.press, this.itemIndex,this.product,
  }) : super(key: key);
  final int itemIndex;
  final Product product;
  final Function press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      //color: Colors.blueAccent,
      height: 150,
      child: InkWell(
        onTap: press,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height:136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Colors.blue[300], 
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1.0, 2.0),
                  blurRadius: 1.0,
                ),
              ],
              ),
              child: Container(
                margin: EdgeInsets.only(right:10),
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(20)
                   ),
              ),
          ),
          Positioned(
              top: 20,
              right: 20,
              child: Hero(
                tag: '${product.id}',
                child: Container(
                  color: Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal:0.0),
                  height: 120,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 150,
                  //child: Image.asset(
                    
                  //  fit: BoxFit.cover,
                 // ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      child: Text(
                        product.title,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10 * 1.5, // 30 padding
                        vertical: 8 / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        "\$${product.price}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
        ),
        ),
    );
  }
}
