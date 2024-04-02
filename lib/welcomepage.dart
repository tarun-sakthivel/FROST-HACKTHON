import 'package:animated_text_kit/animated_text_kit.dart';
import "package:flutter/material.dart";

import 'Signup.dart';
import "constants.dart";
import "login.dart";
class Welcomepage extends StatefulWidget{
  const Welcomepage({super.key});


  @override
  _WelcomepageState createState()=> _WelcomepageState();
}


class _WelcomepageState extends State<Welcomepage>with TickerProviderStateMixin {
  final bool _isLoggedIn= true;
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kbackgroundcolor,
      
      body:SafeArea(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              const Text("NOVO",style:TextStyle(fontSize: 50,
              fontWeight: FontWeight.w600,
            
              color: Color.fromARGB(255, 205, 205, 205))),
              
      
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome',
                    textStyle: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 61, 61, 61),
                    ),
                    speed: const Duration(milliseconds: 300),
                  ),
                ],
                
                
                        ),
              ),
            
      
            Container(
            height:300,
            width: double.infinity,
            
            decoration: const BoxDecoration(
              color: kContainercolor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
            ),
            child:Column(
              children: [
                Padding(
            padding: const EdgeInsets.only(bottom: 50,top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const Login()));
                }, colours: kWelcompagebutton
                , text: "Login"),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(onPressed: (){
                Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const Signup()));
                }, colours: kWelcompagebutton
                , text: "Signup"),
              ],
            ),
                  ),
            
              ],
            ),
            
            ),
      
            
            ],),
          
        ),
      ),
    );
  }
}











