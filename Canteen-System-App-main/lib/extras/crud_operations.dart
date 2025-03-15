import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD extends StatefulWidget{
  const CRUD({super.key});

  @override
  State<CRUD> createState() => _MyCRUD();
}

class _MyCRUD extends State<CRUD> {

  final CollectionReference _items = FirebaseFirestore.instance.collection('names');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)
        {
          if (streamSnapshot.hasData){
            return ListView.builder(itemCount: streamSnapshot.data!.docs.length, itemBuilder: (context, index){
              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              return Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(documentSnapshot['name'], style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(documentSnapshot['batch'], style: TextStyle(color: Colors.white),),
                ),
              );
            });
          }
          return Text("No widget build");
      } ,),
    );
  }
}