import "dart:io";

import  "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";

import "constants.dart";

String _filePath= "";

class Summary extends StatefulWidget {
  final String summary;
  Summary({required this.summary}) ;


  @override
  // ignore: no_logic_in_create_state
  State<Summary> createState() => _SummaryState(summary:summary);
}
class _SummaryState extends State<Summary> {
  late String summary;
  _SummaryState({required this.summary});
  TextEditingController summarytextcontroller = TextEditingController();
  @override
  void initState(){
    super.initState();
    print("helloooooo");
    print("summary is ${summary}");
    summarytextcontroller.text= summary;
    print(summarytextcontroller.text);
    print("above");
  }
  
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

                              Navigator.pop(context);
                            },
                                        icon: Icon(Icons.arrow_back_ios),
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Image.asset("assets/novo_logo1.png"),
                          ),

                          Text("AI Meeting Summary",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                          
                        ],
                      ),
                      
                      Divider(
                        indent: 0,
                        endIndent: 0,
                      ),
                      Text("Click to Edit your notes!!",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color:const Color.fromARGB(255, 206, 206, 206))),
                      /*Expanded(
                        
                        child: Container(
                          width:double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Kappcolorlight,),
                          
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Summary text will be visible here\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n you have scrolled"),
                                ],
                              )),
                          ),
                        ),
                      ),*/
                      /*TextField(
                        controller: summarytextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your text here',
                        ),
                        maxLines: null, // Allows for multiline input
                      ),*/


                      Container(
                  height:500,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: KMyborder,color: Kgreycolor_light,),
                  
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,bottom:5),
                      child: TextField(
                      controller: summarytextcontroller,
                      maxLength: null,
                      maxLines:null,
                        // Allow unlimited lines in the text field
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove default border
                        hintText: 'Here...',
                      ),
                        ),
                  ),
                ),
                    
                      Padding(
                        padding: const EdgeInsets.only(top:30),
                        child: Center(
                          child: GestureDetector(
                           onTap: (){
                              _saveToFile(context);
                              
                           },
                           child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Kappcolor),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Save to File"),
                            )),
                        
                          ),
                        ),
                      )
                      

                    ]
                  ),
                ),
                
              ),
            )));
  }
  Future<void> _saveToFile(BuildContext context) async {
    String textToSave = summary;

    if (textToSave.isNotEmpty) {
      try {
        Directory directory = await getApplicationDocumentsDirectory();
        String filePath = '$directory/my_text_file.txt';
      

        File file = File(filePath);
        await file.writeAsString(textToSave);

        setState(() {
          _filePath = filePath;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Text saved to file')),
        );
      } catch (e) {
        print('Error saving to file: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving to file')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter some text')),
      );
    }
  }
 
   
 
}
