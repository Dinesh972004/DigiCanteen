import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// import '../components/ItemsList.dart';
import '../components/ItemsList.dart';
import 'cartScreen.dart';
import '../components/sideBar.dart';
import '../components/database.dart';

// import 'orders.dart';

class MyHomePage extends StatefulWidget {

  final username;
  const MyHomePage({super.key, this.username});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onTap(){
    setState(() {
      total = orders.values.reduce((prev, element) => prev + element);
      user = widget.username;
      // quantities;
    });
    try{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Cart(total: total)),
      );
    }
    catch(e) {
      if (e is StateError) {
        final snackBar = SnackBar(content: Text('Cart is Empty!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else {
        // General error handling
        final snackBar = SnackBar(content: Text('Error!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('An error occurred: $e');
      }
    }
    // if(mounted) {
    // //   AwesomeDialog(context: context,
    // //       dialogType: DialogType.info,
    // //       animType: AnimType.rightSlide,
    // //       title: 'Dialog Title',
    // //       desc: 'Dialog description here.............',
    // //       btnCancelOnPress: () {},
    // // btnOkOnPress: () {},
    // // )..show();
    //   final snackBar = SnackBar(content: Text('Cart is Empty!'));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Cart(total: total)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Menu"),
        actions: [IconButton(onPressed: onTap, icon: Icon(Icons.shopping_basket_sharp))]
      ),
      drawer: SideBar(name: widget.username,),
      body: SafeArea(
        child: ItemsList()
          ),
        );
  }
}


