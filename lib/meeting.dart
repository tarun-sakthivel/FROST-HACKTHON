
import 'package:camera/camera.dart';
import  "package:flutter/material.dart";
import 'package:meet_interface/upload.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'constants.dart';
import "main.dart";
import "summary.dart";

bool yes = false;

bool ispressed = false;
bool micon = false;
bool cameraon = true;






late CameraController cameraController;
class Meeting extends StatefulWidget {
  

  const Meeting({Key? key}) : super(key: key);
  

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  late String formattedTime;
int cameraside = 1;
String finaltext = "hello";
String works_text = '';
  TextEditingController _textController =
      TextEditingController(); //creating object for the class
  String _filePath = '';
  List<String> List_text = [];
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool _isListening = false;
  List<String> uniqueSentences = [];
  String lastRecognizedWords = '';
  String livewords = "";
  

  
  
  
  
  @override
  void initState(){
    //initSpeech();
    
    super.initState();
    _initSpeech();
    micon = false;
    DateTime now = DateTime.now();

  // Format the current time as a string (HH:mm:ss)
   formattedTime = "${now.hour}:${now.minute}:${now.second}";
    try{
      cameraController = CameraController(cameras[cameraside], ResolutionPreset.ultraHigh);
      cameraController.initialize().then((_){
      if (!mounted){
        return;
      }
      setState(() {
        
      });
    }).catchError((Object e){
      if(e is CameraException){
        switch(e.code){
          case "CameraAccessDenied":
          print("User denied camera access.");
          showErrorDialog(context, "User denied camera access.");
          break;
          default:
          print("handle other errors.");
          showErrorDialog(context, "An error occurred: ${e.code}\nTry restrating the app");
          break;
        }
      }
    });
    }
    catch(e){
      print("no camera is found in the computer, ${e}");
    }
    
    
    }
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    print("listening");
    if (_isListening) {
      print("now started");
      _isListening = true;
      while (_isListening) {
        await _speechToText.listen(
          onResult: _onSpeechResult,
          localeId: 'en-IN',
        );
      }
      
    }
    setState(() {
      _isListening = true;
      _startListening();
    });
  }

  void _stopListening() async {
    
      _isListening = false;
      await _speechToText.stop();
      setState(() {});
    
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      livewords = result.recognizedWords;
      print(result.recognizedWords);
      List_text.add(result.recognizedWords);
      if (result.finalResult) {
        String recognizedWords = result.recognizedWords;

        if (recognizedWords != lastRecognizedWords) {
          if (!uniqueSentences.contains(recognizedWords)) {
            setState(() {
              uniqueSentences.add(recognizedWords);
            });
          }
          lastRecognizedWords = recognizedWords;
        }
      }
      setState(() {
        _textController.text=uniqueSentences.join(' ');
        finaltext= uniqueSentences.join(' ');//contains whole teachers transcript
      print("===============================${finaltext}");
      });
      setState(() {
        
      });
      
     
      _isListening = true;
    });
  }
  


  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  //speech to text part
   


    


  
  
  @override
  Widget build(BuildContext context) {
   
    
    
    return Scaffold(
     
      backgroundColor: Kbackgroundcolor,
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
              
              child: Container(
                height: double.infinity,
                
                decoration: BoxDecoration(color: Kmainboard,borderRadius: KMyborder,),

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: Image.asset("assets/novo_logo1.png"),
                          ),

                          Text(" Meeting",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                          
                        ],
                      ),
                      
                      Divider(
                        indent: 0,
                        endIndent: 0,
                      ),
                      

                      //video container
                      if (!cameraController.value.isInitialized)
                      
                      Expanded(
                        
                        child: Container(
                          width:double.infinity,
                          height:double.infinity,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),

                              Padding(
                                padding: const EdgeInsets.only(top:10),
                                child: Text("If it take time try restarting the app",style: Kcommontextstyle,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Text("This is the word spoken by you $_wordSpoken"),
                      if (cameraController.value.isInitialized)
                      Expanded(
                        child: Center(
                          child: Container(
                            child:Row(
                              children: [
                                
                                Expanded(
                                  flex:3,
                                  
                                  child: yes ?Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Kappcolorlight),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height:double.infinity,
                                            
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                            child:ClipRect(child:Image.asset("assets/No_camera.png",height: 300,))),
                                            Text("Your Camera is off!",style:Kcommontextstyle)
                                      ],
                                    ),
                                  )
                                      
                                      :Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                      child:ClipRect(child:CameraPreview(cameraController))))),
                                SizedBox(
                                  width: 10,
                                ),
                                  Expanded(
                                   
                                  child:
                
                
                                Container(
                                  height:double.infinity,
                                  decoration: BoxDecoration(color: Kappcolor,borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("$livewords",style:TextStyle(fontFamily: "Inter",fontSize: 20,fontWeight: FontWeight.w500)),
                                  ),
                                )   
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        height:20
                      ),
                    

                      
                      SizedBox(
                        height:30
                      ),            //HERE THE VIDEO CONTAINER SHOUL BE THERE
                      Container(
                        color:Colors.transparent,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex:1,
                                
                                child: Container(
                                  child: Text("${formattedTime} | xhdy-123",style: TextStyle(fontFamily: "Inter",fontSize:20,fontWeight: FontWeight.w600),),
                              
                                ),
                              ),
                              Expanded(
                                flex:2,
                                
                                
                                child: Container(
                                              
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                        
                                              
                                    GestureDetector(onTap: (){
                                              
                                setState(() {
                                  micon= !micon;
                                  if (micon == true){
                                    _startListening();
                                  }
                                  else if (micon ==false){
                                    _stopListening();
                                  }
                                });
                              },
                               child: micon? CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 30,
                                child: Center(
                                  child: Icon(Icons.mic,size: 35,color: Colors.white,))):
                                              
                                              
                               CircleAvatar(
                                 backgroundColor: Colors.red,
                                radius: 30,
                                child: Center(
                                  child: Icon(Icons.mic_off,size: 35,color: Colors.white,)))),
                                    SizedBox(
                                      width: 20,
                                    ),
                                              
                                              
                                              
                                  GestureDetector(onTap: (){
                                              
                                setState(() {
                                  yes = !yes;
                                  cameraon= !cameraon;
                                });
                              },
                               child: cameraon? CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 30,
                                child: Center(
                                  child: Icon(Icons.camera_alt,size: 35,color: Colors.white,))):
                                              
                                              
                               CircleAvatar(
                                 backgroundColor: Colors.red,
                                radius: 30,
                                child: Center(
                                  child: Icon(Icons.camera_alt,size: 35,color: Colors.white,)))),
                                  SizedBox(
                                      width: 20,
                                    ),
                                              
                                              
                              Center(
                                child: ElevatedButton(
                                            
                                            style: ElevatedButton.styleFrom(backgroundColor: Kappcolor,
                                            minimumSize: Size(150, 65),
                                            onSurface: Colors.yellow,),
                                            onPressed: (){
                                              //ONPREWSED
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Summary(summary: "$livewords \n\n\n $referencetext",)));
                                             
                                        
                                          },
                                          
                                        child: Text("Finish",style: TextStyle(fontFamily: "Inter",
                                          fontSize: 20,fontWeight: FontWeight.w500,
                                          color:Colors.black),))
                              ),
                              
                                              
                             
                                              
                                  ],
                                ),
                              )),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Upload()));
                                },
                                child: Container(
                                  height:50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:const Color.fromARGB(255, 229, 229, 229)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text("Edit the reference Material")),
                                  ),
                                ),
                              )
                              
                            ],
                          ),
                        ),
                      ),
                              
                    ],
                  ),
                ),
                
              ),
            )));
  }
}




  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

class TextContainer extends StatelessWidget {
  final String finaltext;

  TextContainer({required this.finaltext});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(finaltext, style: TextStyle(fontSize: 50)),
    );
  }
}