import 'package:authentication_firebase/Components/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:authentication_firebase/Components/textfield.dart';
import 'package:authentication_firebase/Components/square_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:authentication_firebase/Authenticate/auth.dart';

class SignupPage extends StatefulWidget {
  final Function()? onTap;
  const SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  ///Text Controller
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ///SignUp user methods
  void signUserUp() async {

    ///Loading Circle after SignIn
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    ///Create User 
    try {
      if (passwordConfirm()) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
        );
        

        ///Store User data from signup to Firestore
        firebaseUser(
          lastnameController.text, 
          firstnameController.text, 
          usernameController.text, 
          emailController.text, 
          passwordController.text);
        
        String displayName = '${firstnameController.text} ${lastnameController.text}';
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.currentUser!.updateDisplayName(displayName);
        

      } else {
        Navigator.pop(context);
        return Passnotsame();
      }

    ///Pop off loading circle
    Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ///Pop off loading circle
      Navigator.pop(context);
      if (e.code == 'user-not-found'){
        wrongEmailPopup();
      } else if (e.code == 'wrong-password') {
        wrongPasswordPopup();
      }
    }
  }

  /// Check password and confirm pass is same
  bool passwordConfirm() {
    if (passwordController.text == confirmPasswordController.text){
      return true;
    } else {
      return false; 
    }
  }

  //
  void firebaseUser (
    String lastName, 
    String firstName, 
    String userName, 
    String email,
    String password,
    
    ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'lastName' : lastName,
      'firstName' : firstName,
      'username': userName,
      'email': email,
      'password' : password,
      
    },
    
    );
  }

  ///Wrong Email Popup
  void wrongEmailPopup() {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 41, 41, 41),
          title: Container(
            child: Text(
              'Incorrect Email or Email doesn''\'t exist!', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  ///Wrong Password Popup
  void wrongPasswordPopup() {
    showDialog(
      context: context, 
      builder: (context){
        return const AlertDialog(
          title: Text(
            'Incorrect Password',          
            ),
        );
      },
    );
  }

  ///Password not same
  void Passnotsame() {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 41, 41, 41),
          title: Container(
            child: Text(
              'Password is not same', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    ).then((value){
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const SizedBox(height: 0),
      
                // Logo App
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
      
                const SizedBox(height: 5),
      
                // Welcome Text
                Text(
                  'Let\'s create new account!!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      
                const SizedBox(height: 5),
      
                //Username
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
      
                const SizedBox(height: 10),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: 
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: firstnameController,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(color: Colors.grey[500])
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: lastnameController,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: 'Last Name',
                                  hintStyle: TextStyle(color: Colors.grey[500])
                                ),
                              ),
                            ),
                          ]),
                        ),
                         // Add some space between the text form fields
                        

                ///FirstName
                // MyTextField(
                //   controller: firstnameController,
                //   hintText: 'First Name',
                //   obscureText: false,
                // ),
                // // Lastname
                // MyTextField(
                //   controller: lastnameController,
                //   hintText: 'Last Name',
                //   obscureText: false,
                // ),

                const SizedBox(height: 10),
      
                // Emailname textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,               
                ),
      
                const SizedBox(height: 10),
                // password textfield
                
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,               
                ),
      
                const SizedBox(height: 10),
      
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,               
                ),
      
                const SizedBox(height: 20),
      
                // sign in button
                authButton(
                  options: "Sign up",
                  onTap: signUserUp, 
                ),
      
                const SizedBox(height: 15),
      
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15),
        
                // continue with gg apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'assets/images/google.png'),
                    SizedBox(width: 25),
                  ],
                ),
      
                const SizedBox(height: 15),
              
              
                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}