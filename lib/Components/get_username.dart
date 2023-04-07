// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class getUserName extends StatelessWidget {
  final String documentID;
  getUserName({required this.documentID});

  @override
  Widget build(BuildContext context) {
    ///Get collection from Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        String displayName = '${data['firstName']} ${data['lastName']}';

        FirebaseAuth auth = FirebaseAuth.instance;
        auth.currentUser!.updateDisplayName(displayName);
        return Text(
          displayName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),);
      }
      return Text('Loading...');
    }));
  }
}