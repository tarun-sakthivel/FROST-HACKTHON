
import  "package:flutter/material.dart";

import 'constants.dart';
import "meeting.dart";
bool yes = false;

bool ispressed = false;
bool micon = false;
bool cameraon = true;







class Upload extends StatefulWidget {
  

  const Upload({Key? key}) : super(key: key);
  

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  
  
TextEditingController _referencetextcontroller = TextEditingController();
  
  
  
  
  @override
  void initState(){
    //initSpeech();
    
    super.initState();
    
    
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                            child: IconButton(onPressed: (){

                              //Navigator.pop(context);
                            },
                                        icon: Icon(Icons.arrow_back_ios),
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: Image.asset("assets/novo_logo1.png"),
                          ),

                          Text(" Uploads",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                          
                        ],
                      ),
                      
                      Divider(
                        indent: 0,
                        endIndent: 0,
                      ),
                      
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex:2,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Upload the reference text for notes generation")  ,  
                                  /*TextField(
                                    controller: _referencetextcontroller,
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                      
                                      hintText: 'Place the reference text here',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                    ),
                                  ),*/
                                  Container(
                                                            
                                height: 500.0,  
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Color.fromARGB(255, 237, 237, 237),),// Set the desired height
                                child: SingleChildScrollView(
                                  child: TextField(
                                    controller: _referencetextcontroller,
                                    style: TextStyle(),
                                    maxLines: null,  // Allows for an unlimited number of lines
                                    decoration: InputDecoration(
                                      hintText: 'Place the reference text here',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                    ),
                                  ),
                                ),
                                                      ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      referencetext=  _referencetextcontroller.text;
                                      print("=========================REFERENE TEXT IS ============================\n$referencetext");
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Meeting()));
                                    },
                                    child: Container(
                                      height:50,
                                      width:200,
                                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(30),color:Colors.red),
                                      child:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text("Start Meeting",style:TextStyle(fontFamily: "inter",fontSize: 20,color:Colors.white))),
                                      ),
                                      ),
                                      
                                   
                                    ),
                                  
                              
                                                        ],),
                              ),
                             Expanded(
                              flex:1,
                              child: Image(image: AssetImage("assets/reference.png"))),
                            
                            ],
                          ),
                          
                        ),
                      )

                    ]
                        ),
                      ),
                              
               
                  ),
                ),
                
              ),
       
    );
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