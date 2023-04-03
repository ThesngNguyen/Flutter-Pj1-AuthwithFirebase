import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Create firebase auth instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  /// Methods create Account
  Future<void> signUpWithEmailAndPassword(
      String email, String password) async {
        
    final user = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password);
  }

  //Methods login Account
  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}