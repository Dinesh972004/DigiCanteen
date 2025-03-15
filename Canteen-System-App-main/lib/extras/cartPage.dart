// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../components/homeScreen.dart';
// import '../components/database.dart';
// // import 'orders.dart';
//
// import '../components/orderList.dart';
//
// class Cart extends StatefulWidget {
//   final total;
//   const Cart({super.key, required this.total});
//
//   @override
//   State<Cart> createState() => _CartState();
// }
//
// class _CartState extends State<Cart> {
//
//   final CollectionReference _ordersCollection = FirebaseFirestore.instance.collection('canteen');
//
//   void onTap(){
//     Navigator.pop(
//       context,
//       MaterialPageRoute(builder: (context) => MyHomePage()),
//     );
//   }
//
//   Future<void> addOrder(Map orders, String user) async {
//     try {
//       final DocumentReference _ordersDoc = _ordersCollection.doc('orders');
//       final CollectionReference _orderCollection = _ordersDoc.collection('orderNumber');
//       await _orderCollection.add({
//         'order': orders,
//         'user': user,
//       });
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.success,
//         animType: AnimType.rightSlide,
//         title: 'Success!',
//         desc: 'Your order has been placed successfully',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//     } catch (e) {
//       print('Error adding order: $e');
//     }
//     setState(() {
//       orders.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           leading: IconButton(onPressed: onTap, icon: Icon(Icons.arrow_back)),
//           title: Text("Cart"),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               OrderList(),
//               Container(
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
//                       SizedBox(width: 150,),
//                       Text("${widget.total} Rs", textAlign: TextAlign.right, style: TextStyle(fontSize: 20),),
//                     ]
//                 ),
//               ),
//               SizedBox(height: 20,),
//               // ElevatedButton(onPressed: (){}, child: Text("CONFIRM ORDER")),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.green,
//                 child: TextButton(onPressed: ()=>addOrder(orders,user), child: Text("CONFIRM ORDER", style: TextStyle(color: Colors.white, fontSize: 30),),),
//               )
//             ],
//           ),
//         )
//     );
//   }
// }