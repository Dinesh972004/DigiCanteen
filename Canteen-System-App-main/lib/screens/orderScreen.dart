import 'package:firebase_connection/components/ordersList.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  void onTap(){
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: onTap, icon: Icon(Icons.arrow_back)),
          title: Text("Orders"),
        ),
        body: SingleChildScrollView(
          child: Column(
                children: [
                  SizedBox(height: 20,),
                  OrdersList(),
                ],
              ),
          ),
        );
  }
}