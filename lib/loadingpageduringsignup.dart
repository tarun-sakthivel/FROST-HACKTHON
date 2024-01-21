import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:meet_interface/upload.dart";

import "Signup.dart";
import "constants.dart";

final _auth = FirebaseAuth.instance;

class LoadingPagesignup extends StatefulWidget {

  @override
  _LoadingPagesignupState createState() => _LoadingPagesignupState();
  late String emailtext;
  late String passwordtext;
  LoadingPagesignup({required this.emailtext, required this.passwordtext});
}

class _LoadingPagesignupState extends State<LoadingPagesignup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createaccount(context,widget.emailtext, widget.passwordtext);
  }
@override
Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Kbackgroundcolor,
    body: Center (child : CircularProgressIndicator(),),);
  
}

  
}


Future<void> createaccount(BuildContext context, String email, String password) async {
  try {
   
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (newUser != null) {
      print("Registered correctly");
      Navigator.pop(context);
      
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Upload()));
    } else {
      print("this is else part");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ErrorDialog(title: "Error", content: "There is an Error")));
    }
  } catch (e) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ErrorDialog(title: "Error", content: "$e ")));
    print("there is an error: $e");
  }
}


/*void createaccount(String email,String passoword){
  try {
                  final newUser = await _auth.createUserWithEmailAndPassword(email:emailcontroller.text, password: passwordcontroller.text);

                  if (newUser != null) {
                    print("Registered correctly");
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Interest()));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ErrorDialog(title: "Congraluation", content: " You Successfully Signed up")));
                  
                  }else{
                    print("this is else part");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ErrorDialog(title: "Error", content: "There is a Error")));
                  }
                } catch (e) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ErrorDialog(title: "Error", content: "$e ")));
                  print("there is a error ==================================$e");
  }
      
}*/
