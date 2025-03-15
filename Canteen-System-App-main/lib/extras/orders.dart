// import 'package:firebase_connection/components/quantity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsList extends StatefulWidget{
  const ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final CollectionReference _orders = FirebaseFirestore.instance.collection('orders');
  var counter = 1;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: _orders.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)
          {
            if (streamSnapshot.hasData){
              return ListView.builder(itemCount: streamSnapshot.data!.docs.length, itemBuilder: (context, index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete),
                  ),
                  key: ValueKey<int>(index),
                  onDismissed: (direction){
                    setState(() {
                      documentSnapshot['item'].removeAt(index);
                      //remove the item from database
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${documentSnapshot['item']} dismissed")));
                  },

                  child: Card(
                    color: Colors.white,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: Text(documentSnapshot['item']),
                        subtitle: Text('${documentSnapshot['price'].toString()} Rs'),
                        /////
                        trailing: Container(
                            height: 300,
                            width: 200,
                            // color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(onPressed: (){
                                  setState(() {
                                    counter++;
                                  });
                                }
                                  , icon: Icon(Icons.add),),
                                Padding(padding: const EdgeInsets.all(20),
                                  child: Text('${counter.toString()}'),),
                                IconButton(onPressed: (){
                                  if (counter > 1){
                                    setState(() {
                                      counter--;
                                    });
                                  }
                                }
                                    , icon: Icon(Icons.remove)),
                              ],
                            )
                        ),
                    ),
                  ),
                );
              });
            }
            return Text("No widget build");
          }
      ),
    );
  }
}