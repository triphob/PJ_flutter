import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id, price;
  final String title, description, image;
  Product({this.id, this.price, this.title, this.description, this.image});
}

// list of products
// for our demo
Future<void> addUser()
{ var cities = FirebaseFirestore.instance
    .collection('product')
    .get()
    .then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) {
          Product(
            id:doc["id"],
            title:doc["product_name"],
            price: doc["product_price"],
            image: doc["product_image"],
            description:doc["product_detial"],
          );
        })
    });
    return cities;
}
List<Product> products = [
  
  Product(
    id: 1,
    price: 40,
    title: "Classic Leather Arm Chair",
    image: "",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  
];