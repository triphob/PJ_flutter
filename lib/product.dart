import 'package:flutter/material.dart';
import 'package:projectlogin/value_all.dart';
import 'package:projectlogin/models/product_model.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: buildAppBar(context),
      body:Stack(
              children: <Widget>[
                Text(product.title),
                
              ],
              ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF035AA6),
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: Icon(Icons.arrow_back), 
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {},
        ),
      ],
    );
  }
}