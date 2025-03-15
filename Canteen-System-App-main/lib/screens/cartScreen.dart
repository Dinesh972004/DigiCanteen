import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';
import '../components/database.dart';
// import 'orders.dart';

import '../components/orderList.dart';

class Cart extends StatefulWidget {
  final total;
  const Cart({super.key, required this.total});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  final CollectionReference _ordersCollection = FirebaseFirestore.instance.collection('canteen');
  var price, quantity;

  void onTap(){
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  Future<void> addOrder(Map orders, String user) async {
    try {
      final DocumentReference _ordersDoc = _ordersCollection.doc('orders');
      final CollectionReference _orderCollection = _ordersDoc.collection('orderNumber');
      await _orderCollection.add({
        'order': orders,
        'user': user,
        'quantity': quantities,
        'total': total
      });
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Success!',
            desc: 'Your order has been placed successfully',
      btnOkOnPress: () {
        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      },
      )..show();
    } catch (e) {
      print('Error adding order: $e');
    }
    setState(() {
      // orders.clear();
      // quantities.clear();
      total=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: onTap, icon: Icon(Icons.arrow_back)),
        title: Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: orders.entries
                  .map(
                    (entry) => Dismissible(
                  key: Key(entry.key),
                  onDismissed: (direction) {
                    setState(() {
                      orders.remove(entry.key);
                      quantities.remove(entry.key);
                      price = entry.value;
                      quantity = quantities[entry.key]!;
                      var remove = price*quantity;
                      total -= remove;
                      // total -=price;
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                  ),
                  child: ListTile(
                    leading: Text('${quantities[entry.key]}'),
                    title: Text(entry.key),
                    subtitle: Text('${entry.value.toString()} Rs'),
                    trailing: Container(
                      height: 200,
                      width: 125,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantities[entry.key] = quantities[entry.key]! + 1;
                                price = orders[entry.key];
                                total +=price;
                                // You can add logic to update the total or do other operations here
                              });
                            },
                            icon: Icon(Icons.add_circle_outline),
                          ),
                          // Text('${quantities[entry.key]}', style: TextStyle(fontSize: 15)),
                          IconButton(
                            onPressed: () {
                              if (quantities[entry.key]! > 1) {
                                setState(() {
                                  quantities[entry.key] = quantities[entry.key]! - 1;
                                  total -=price;
                                  // You can add logic to update the total or do other operations here
                                });
                              }
                            },
                            icon: Icon(Icons.remove_circle_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                 SizedBox(width: 150,),
                 Text("${total} Rs", textAlign: TextAlign.right, style: TextStyle(fontSize: 20),),
               ]
              ),
            ),
            SizedBox(height: 20,),
            // ElevatedButton(onPressed: (){}, child: Text("CONFIRM ORDER")),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: TextButton(onPressed: ()=>addOrder(orders,user), child: Text("CONFIRM ORDER", style: TextStyle(color: Colors.white, fontSize: 30),),),
            )
          ],
        ),
      )
    );
  }
}