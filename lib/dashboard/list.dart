import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, image;

  Product({required this.id, required this.title, required this.image});
}

// list of products
// for our demo
List<Product> products = [
  Product(
    id: 1,
    title: "Donate Food",
    image: "assets/clothes.png",
   
   
  ),
  Product(
    id: 4,
    title: "Donate Clothes",
    image: "assets/cloth1.png",
    ),
  Product(
    id: 9,
    title: "Donate Books",
    image: "assets/book2.png",
  
  ),
  
];