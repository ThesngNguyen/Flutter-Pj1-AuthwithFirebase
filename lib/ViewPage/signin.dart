import 'package:authentication_firebase/Components/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:authentication_firebase/Components/textfield.dart';
import 'package:authentication_firebase/Components/square_tile.dart';

class SigninPage extends StatefulWidget {
  final Function()? onTap;
  const SigninPage({super.key, required this.onTap});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  ///Text Controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  ///SignIn user methods
  void signUserIn() async {

    ///Loading Circle after SignIn
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    ///Sign In
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
      );
    
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
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
                'Welcome back!!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'You have been missed!!!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5),

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

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // sign in button
              authButton(
                options: "Sign In",
                onTap: signUserIn,
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
                    'Not a member ?',
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
                      'Register now',
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
    );
  }
}