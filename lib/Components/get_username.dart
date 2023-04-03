// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class getUserName extends StatelessWidget {
//   final String documentID;
//   const getUserName({required this.documentID});

//   @override
//   Widget build(BuildContext context) {
//     ///Get collection from Firestore
//     CollectionReference users = FirebaseFirestore.instance.collection('users');


//     return FutureBuilder<DocumentSnapshot>(builder: ((context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {
//         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//       }
//     }));
//   }
// }