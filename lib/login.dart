import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:meet_interface/upload.dart";

import "Signup.dart";
import "constants.dart";
class Login extends StatefulWidget{
  const Login({super.key});


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  
  final _auth= FirebaseAuth.instance;

  late String email;
  late String password;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Kbackgroundcolor,
      body: SingleChildScrollView(
        
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            
            Container(
            height:450,
            decoration: const BoxDecoration(
              color: kContainercolor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: Text("Login",style:TextStyle(color: Colors.white,fontSize: 55,fontFamily: "Pacifico")),
                ),

                entrytext(controller: emailcontroller,hint:"Email",secure:false),
                entrytext(controller: passwordcontroller,hint:"Password",secure:true),
              ],
            ),
            
            ),
      
            Padding(
              padding: const EdgeInsets.only(top:60,bottom: 60),
              child: CustomButton(onPressed: ()async{
                
                
                try{
                  
                
                print(emailcontroller.text);
                print( passwordcontroller.text);
                
                final user = await _auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
                // ignore: unnecessary_null_comparison
                if (user != null){
                  print("everthying went well");
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const Upload()));
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=>Info_loader()));
                  emailcontroller.clear();
                  
                  passwordcontroller.clear();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ErrorDialog(title: "Congrulation", content: " You Successfully Logged In")));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ErrorDialog(title: "Error", content: " ")));
                }
              }
              catch(e){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ErrorDialog(title: "Error", content: "$e ")));
                print ("error");

              }
              
                
              },
              colours: kWelcompagebutton,
              text: "Login"),
            ),
          
      
            Padding(
              padding: const EdgeInsets.only(bottom: 30,top:80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",style:TextStyle(color: Color.fromARGB(255, 198, 198, 198))),
      
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup()));
                  },
                  child: const Text("Sign up",style: TextStyle(color:Colors.blue),))
                ],
              ),
            ),
          
          
          ]
        ),
      ),
    );
  }
}
