import 'package:firebase_connection/components/orderList.dart';
import 'package:firebase_connection/screens/cartScreen.dart';
import 'package:firebase_connection/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';

class ItemsList extends StatefulWidget{
  const ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final CollectionReference _mainCollection = FirebaseFirestore.instance.collection('canteen');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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

        // Assuming the subcollection is named 'sub_collection'
        CollectionReference subCollectionRef = _mainCollection.doc('menu').collection('items');

        return StreamBuilder<QuerySnapshot>(
          stream: subCollectionRef.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> subCollectionSnapshot) {
            if (subCollectionSnapshot.hasError) {
              return Text('Error: ${subCollectionSnapshot.error}');
            }

            if (subCollectionSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (subCollectionSnapshot.data!.docs.isEmpty) {
              return Center(child: Text('No documents in the subcollection'));
            }

            return ListView(
              children: subCollectionSnapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                final imageURL = data['imageURL'];
                final item = data['item'];
                final price = data['price'];

                return ListTile(
                  isThreeLine: true,
                  leading: Image.network(imageURL, width: 70,),
                  title: Text(item),
                  subtitle: Text('${price.toString()} Rs'),
                  trailing: IconButton(onPressed: (){
                    //add item to cart list
                    orders[item] = price;
                    prices[price];
                    print(orders);

                  }, icon: Icon(Icons.add),),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
