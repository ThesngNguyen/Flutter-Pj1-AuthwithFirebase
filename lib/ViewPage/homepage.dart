import 'package:authentication_firebase/Components/get_username.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  HomePage({super.key});


  final user = FirebaseAuth.instance.currentUser;

  ///Doc IDs
  List<String> docIDs = [];

  ///Method get DocsID
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user?.email).get().then((data) => data.docs.forEach((document) {
      print(document.reference);
      docIDs.add(document.reference.id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text(
          'Signed in as : ${user?.displayName}' ,
          ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Logged in as',
              style: TextStyle(
                fontSize: 34,
              ),
              ),
            
            Expanded(
              child: FutureBuilder(
                future: getDocID(),
                builder: (context , snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context , index) {
                      return ListTile(
                        title: getUserName(documentID: docIDs[index]),
                      );
                    },
                  );
                },              
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              }, 
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      
    );
    
  }
}