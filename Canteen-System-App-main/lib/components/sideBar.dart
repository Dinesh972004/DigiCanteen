import 'dart:io';
import 'package:firebase_connection/screens/loginScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../screens/orderScreen.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final name;
  const SideBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {

    final String microsoftFeedbackFormUrl = 'https://forms.office.com/r/d7TFu7TuwG';
    final String microsoftComplaintFormUrl = 'https://forms.office.com/r/iTYZkY84F0';

    void launchFeedbackForm() async {
      if (await canLaunch(microsoftFeedbackFormUrl)) {
        await launch(microsoftFeedbackFormUrl);
      } else {
        // Handle error, e.g., show an error message
        print('Error launching Microsoft Form');
      }
    }

    void launchComplaintForm() async {
      if (await canLaunch(microsoftComplaintFormUrl)) {
        await launch(microsoftComplaintFormUrl);
      } else {
        // Handle error, e.g., show an error message
        print('Error launching Microsoft Form');
      }
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(Icons.person, size: 130, color: Colors.white,)
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 60,),
                    Text("$name",style: TextStyle(color: Colors.white,)),
                    // Text("roll#", style : TextStyle(color: Colors.white,)),
                  ],
                ),
              ],
            )
          ),
          ListTile(
            title: Text('Orders'),
            onTap: () {
              // Navigate to the Orders screen or perform related actions
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Feedback'),
            onTap: () {
              launchFeedbackForm();
            },
          ),
          ListTile(
            title: Text('Complaint'),
            onTap: () {
              launchComplaintForm();
            },
          ),


          SizedBox(height: 30,),
          Divider(),

          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Perform logout actions
              // For example, you can show a confirmation dialog and log the user out
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform logout actions here
                          // For now, just pop to the root of the navigation stack
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
  // _launchMicrosoftForms() async {
  //   const microsoftFormsUrl = 'YOUR_MICROSOFT_FORMS_URL'; // Replace with your Microsoft Forms URL
  //   if (await canLaunchUrlString(microsoftFormsUrl)) {
  //     await launchUrlString(microsoftFormsUrl);
  //   } else {
  //     throw 'Could not launch $microsoftFormsUrl';
  //   }
  // }

}