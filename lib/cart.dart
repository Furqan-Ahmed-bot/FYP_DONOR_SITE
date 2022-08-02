// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dashboard_final/food_donation.dart';
import 'package:dashboard_final/models/booksCartModel.dart';
import 'package:dashboard_final/models/clothesCartModel.dart';
import 'package:dashboard_final/models/donationCartModel.dart';

import 'bookDonation.dart';
import 'clothesDonation.dart';
import 'donationBox.dart';

import 'package:flutter/material.dart';

class CartApp extends StatefulWidget {
  int donorId;
  int ngoId;
  final fow;
  CartApp(this.donorId, this.ngoId, this.fow);
  @override
  _CartAppState createState() => _CartAppState();
}

class _CartAppState extends State<CartApp> {
  List<ProductModel> foodCart = [];
  List<BooksModel> bookCart = [];
  List<ClothesModel> clothesCart = [];
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("Confirm Donation"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Donation",
              ),
              Tab(
                text: "Donation Box",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            widget.fow == 'food'
                ? ConfirmFoodDonation(widget.donorId, widget.ngoId,
                    (selectedProduct) {
                    setState(() {
                      foodCart.add(selectedProduct); //update
                    });
                  })
                : widget.fow == 'clothes'
                    ? ConfirmClothesDonation(widget.donorId, widget.ngoId,
                        (selectedProduct) {
                        setState(() {
                          clothesCart.add(selectedProduct); //update
                        });
                      })
                    : ConfirmBookDonation(widget.donorId, widget.ngoId,
                        (selectedProduct) {
                        setState(() {
                          bookCart.add(selectedProduct); //update
                        });
                      }),
            widget.fow == 'food'
                ? CheckoutScreen(
                    foodCart, widget.ngoId, widget.donorId, widget.fow)
                : widget.fow == 'clothes'
                    ? CheckoutScreen(
                        clothesCart, widget.ngoId, widget.donorId, widget.fow)
                    : CheckoutScreen(
                        bookCart, widget.ngoId, widget.donorId, widget.fow),
          ],
        ),
      ),
    );
  }
}
