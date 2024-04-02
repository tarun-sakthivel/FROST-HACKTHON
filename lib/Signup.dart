import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "constants.dart";
import "loadingpageduringsignup.dart";
import "login.dart";


class Signup extends StatefulWidget{
  const Signup({super.key});


  @override
  
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup>{
  

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
   
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
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
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text("Sign up",style:TextStyle(color: Colors.white,fontSize: 55,fontFamily: "Pacifico")),
                ),
                entrytext(controller: usernamecontroller,hint:"UserName",secure:false),
                entrytext(controller: emailcontroller,hint:"Email",secure:false),
                entrytext(controller: passwordcontroller,hint:"Password",secure:true),
              ],
            ),
            
            ),
      
            Padding(
              padding: const EdgeInsets.only(top:60,bottom: 60),
              child: CustomButton(onPressed: ()async{
                
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingPagesignup(emailtext: emailcontroller.text,passwordtext: passwordcontroller.text,)));
                
              
                
                      
                    
                
              },
              colours: kWelcompagebutton,
              text: "Sign up"),
            ),
          
      
            Padding(
              padding: const EdgeInsets.only(bottom: 30,top:80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Already have an account?",style:TextStyle(color: Color.fromARGB(255, 198, 198, 198))),
      
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                  },
                  child: const Text("Login",style: TextStyle(color:Colors.blue),))
                ],
              ),
            ),
          
          
          ]
        ),
      ),

    );
  }
}
class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}class entrytext extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool secure;

  const entrytext({super.key, required this.controller,required this.hint,required this.secure});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: TextField(
        
        style:const TextStyle(color: Colors.white,fontFamily: "Commmissioner"),
        obscureText:secure ,
        controller: controller,
      decoration: InputDecoration(


        //BORDER
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(color: Color.fromARGB(255, 138, 138, 138)), // Rounded border
        ),


        //ENABLED BORDER
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(color: Color.fromARGB(255, 101, 101, 101)), // Rounded border
        ),


        //FOCUSED BORDER
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)), // Rounded border
        ),


        //HINT TEXT
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 79, 79, 79),
          fontFamily: "Commissioner",
        ),
      ),
    ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color colours;
  final String text;

  const CustomButton({super.key, required this.onPressed,required this.colours,required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: colours,shadowColor: Colors.black),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}