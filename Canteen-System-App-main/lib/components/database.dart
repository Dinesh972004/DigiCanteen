import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/loginScreen.dart';

//functions and widgets

/*WIDGETS
* MenuList widget
* CartList widget
* OrderList widget
* Confirm order widget
* Login widget
* Quantity widget
* TotalAmount widget
* */

/*FUNCTIONS
* Render data from collections
* Add data to documents
* Confirm order function
* Login function
* Quantity function
* TotalAmount function
* */

final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('canteen');
final DocumentReference _usersDoc = _usersCollection.doc('users');

var user = '';
var orders = {};
Map<String, int> quantities = Map.fromIterable(
  orders.keys,
  key: (key) => key as String,
  value: (key) => 1,
);
// var counter = 1;
// var quantity = 1;
var prices = [];


var total = orders.values.reduce((prev, element) => prev + element);

// void AddtoTotal(price){
//   total = total + price;
// }
// void SubfromTotal(price){
//   total = total - price;
// }
//
// int total = orders.values.reduce((prev, element) => prev + element);
















