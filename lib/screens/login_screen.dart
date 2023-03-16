import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  String password;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
   inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

                Flexible(
                child: Hero(
                  tag:'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                decoration:kTextDecoration.copyWith(hintText: 'Enter Your Email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password=value;

                  //Do something with the user input.
                },
                decoration: kTextDecoration.copyWith(hintText: 'Enter Your Password')
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(colour: Colors.blueAccent, title: 'Log In',onPressed:()async{
    try{
      setState(() {
        showSpinner=true;
      });
    final user =await _auth.signInWithEmailAndPassword(email: email, password: password);
    if(user!=null){
    Navigator.pushNamed(context,ChatScreen.id);
    }setState(() {
      showSpinner=false;
    });
    }

    catch(e)
    {
        print (e);
              }
  }
  ,)
            ],
          ),
        ),
      ),
    );
  }
}
