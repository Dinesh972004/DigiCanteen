import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connection/components/sideBar.dart';
import 'package:firebase_connection/screens/homeScreen.dart';
import 'package:flutter/material.dart';

import '../components/database.dart';
import '../components/login_button.dart';
import '../components/textfield.dart';


class LoginScreen extends StatefulWidget{

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final emailController = TextEditingController();

  final passController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onTap() async {
    String email = emailController.text.trim();
    String password = passController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Handle empty fields
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: '$email@ssuet.edu.pk',
        password: password,
      );
      final snackBar = SnackBar(content: Text('Logged in as ${email}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Authentication successful, you can navigate to the next screen or perform other actions
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(username: email,),
        ),
      );
      print('User authenticated: ${userCredential.user?.uid}');
    } catch (e) {
      final snackBar = SnackBar(content: Text('Incorrect Login'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //   Logo
              Image.asset("assets/images/canteen_logo2.png", alignment: Alignment.center,),

              //   EmailID
              TextInput(
                controller: emailController,
                hintText: "ID",
                obscureText: false,
              ),
              SizedBox(height: 15,),
              //   Password
              TextInput(
                controller: passController,
                hintText: "Password",
                obscureText: true,
              ),
              SizedBox(height: 20,),
              //   Log in
              LoginButton(
                // onTap: () => debugPrint("Pressed!"),
                onTap: () =>  onTap(),
              ),
            ],
          ),
        ),
    );
  }
}