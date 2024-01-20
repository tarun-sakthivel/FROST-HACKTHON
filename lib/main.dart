import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import "meeting.dart";
//create a cameras varriable
late List<CameraDescription>  cameras ;

void main() async{
  
  
  WidgetsFlutterBinding.ensureInitialized();
  try{
  cameras = await availableCameras();
  }
  on Exception catch (_, e){
    print("error in getting cameras");
    print(e.toString());
    return;
  }
 
  runApp( MainApp());
 
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Meeting(

        ),
      ),
    );
  }
}