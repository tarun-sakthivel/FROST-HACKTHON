import "dart:convert";
import "dart:io";

import  "package:flutter/material.dart";
import 'package:http/http.dart' as http;
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
    summarytextcontroller.text=
    "  1 - Plants act as nature's chefs, utilizing sunlight for their own food.\n"
    "  2 - Chloroplasts, like culinary factories, contain chlorophyll, the key ingredient.\n\n"

    
    "  3 - Sunlight powers the production of energy-rich molecules.\n"
    "   4- Chlorophyll captures sunlight, initiating the process.\n\n"

    
    "  5 - Carbon dioxide transforms into glucose.\n"
    "   6- This stage occurs in the chloroplast's stroma.\n\n"

   
    "  7 - The process releases oxygen as a byproduct.\n"
    "  8 - Essential for sustaining life on Earth.\n\n"

    
    "  9 - Plants are akin to solar panels, capturing sunlight for energy.\n"
    "  10 - Chloroplasts function as tiny factories with chlorophyll as a special ingredient.\n\n"

   
    "  11 - Photosynthesis involves two main stages – light-dependent and light-independent.\n"
    "  12 - Light-dependent reactions produce ATP and NADPH using energized electrons.\n\n"

    
;
    print(summarytextcontroller.text);
    print("above");

    print("======================prediction============================");
    makePrediction("n Havana, after a storm, a car embedded in a wall reveals a woman's body, identified as the housekeeper for the new Portuguese ambassador. The narrator recalls Frau Frieda, a dream interpreter in Vienna, whose prophetic dreams led him to leave the city years ago. In Barcelona, the narrator encounters Frau Frieda again, now wealthy, having taken over the fortune of her former patrons. Pablo Neruda dismisses her dreams, but she persists. Thirteen years later, the narrator hears of her through a snake ring found on a victim in Havana, leaving her fate uncertain.");





    


  }


  Future<void> makePrediction(String transcript) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:5000/predict'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'transcript': transcript,
    }),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    String prediction = data['prediction'];
    // Handle the prediction in your Flutter app
    print('Prediction: $prediction');
  } else {
    // Handle errors
    print('Error: ${response.reasonPhrase}');
  }
}
  
  @override
  Widget build(BuildContext context) {
    if (summarytextcontroller.text.isEmpty){
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

                          Text("Enhanced Notes",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                          
                        ],
                      ),
                      
                      Divider(
                        indent: 0,
                        endIndent: 0,
                      ),])))))

      );
    }
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

                          Text("Enhanced Notes",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                          
                        ],
                      ),
                      
                      Divider(
                        indent: 0,
                        endIndent: 0,
                      ),
                      Text("Click to Edit your notes!!",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color:const Color.fromARGB(255, 206, 206, 206))),
                      


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
