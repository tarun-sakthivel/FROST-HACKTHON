import "dart:io";

import  "package:flutter/material.dart";

import "constants.dart";

String _filePath= "";
TextEditingController summarytextController = TextEditingController(text:"hello  this is the summary of the AI");
class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
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

                          Text("AI Meeting Summary",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                          
                        ],
                      ),
                      
                      Divider(
                        indent: 0,
                        endIndent: 0,
                      ),
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
                      controller: summarytextController,
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
                              _saveToFile();
                              
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
  /*Future<void> _saveToFile(BuildContext context) async {
    String textToSave = summarytextController.text;

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
  }*/
  void _saveToFile(){
    String tosave = summarytextController.text;
    File file = File("asnwer.txt");
    file.writeAsStringSync(tosave);
  }
   
 
}
