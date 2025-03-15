import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final CollectionReference _mainCollection =
  FirebaseFirestore.instance.collection('canteen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _mainCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No documents available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot mainDocument = snapshot.data!.docs[index];

              // Assuming the subcollection is named 'orderNumber'
              CollectionReference subCollectionRef =
              mainDocument.reference.collection('orderNumber');

              return StreamBuilder<QuerySnapshot>(
                stream: subCollectionRef.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> subCollectionSnapshot) {
                  if (subCollectionSnapshot.hasError) {
                    return Text('Error: ${subCollectionSnapshot.error}');
                  }

                  if (subCollectionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (subCollectionSnapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text('No documents in the subcollection'));
                  }

                  return Column(
                    children: subCollectionSnapshot.data!.docs
                        .map((DocumentSnapshot orderDocument) {
                      Map<String, dynamic> orderData =
                      orderDocument.data() as Map<String, dynamic>;

                      // final order = orderData['order'];
                      final user = orderData['user'];
                      // final quantity = orderData['quantity'];
                      final total = orderData['total'];

                      return ListTile(
                        title: Text(total.toString()),
                        subtitle: Text(user),
                        // Example of displaying order details
                        // title: Text('Order: ${order.keys} ${order.values} Rs'),
                      );
                    }).toList(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
