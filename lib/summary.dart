import 'dart:convert';
import 'dart:io';
import 'package:meet_interface/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

String _filePath = "";

class Summary extends StatefulWidget {
  final String summary;
  final String pdffile;
  const Summary({super.key, required this.summary, required this.pdffile});

  @override
  // ignore: no_logic_in_create_state
  State<Summary> createState() => _SummaryState(summary: summary);
}

class _SummaryState extends State<Summary> {
  late String summary;

  _SummaryState({required this.summary});
  TextEditingController summarytextcontroller = TextEditingController();
  String? _fileName;
  FilePickerResult? result;
  PlatformFile? pickedfile;
  bool isLOading = false;
  File? fileToDisplay;
  List pickedfiles = [];
  String pathofFile = '';
  String sumarized_text = '';
  String base64String = '';
  String manual_text = '';
  void pickFile() async {
    try {
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['ppt', 'pdf'],
          allowMultiple: true);
      if (result != null) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
        pathofFile = pickedfile!.path.toString();
        print("File name: $_fileName");
        base64String = base64Encode(File(pathofFile).readAsBytesSync());
      }
      if (result != null) {
        setState(() {
          pickedfiles = result!.files.map((file) => File(file.path!)).toList();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  openFile(File) {
    OpenFile.open(File.path);
  }

  Future fetchData() async {
    print("hi");
    var url = 'https://karthiksagar.us-east-1.modelbit.com/v1/run_model/latest';
    var headers = {'Content-Type': 'application/json'};
    print(base64String);
    var body = json.encode({
      "data": [base64String, summary],
    });
    print("stage2");
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      print("success");
      // Request successful, do something with the response.
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // Access the value of the "response" key
      String botResponse = jsonResponse['data'];
      // Print or return the bot response
      print("Bot response: $botResponse");
      setState(() {
        sumarized_text = botResponse;
        summarytextcontroller.text = sumarized_text;

        print(summarytextcontroller.text);
      });
      setState(() {
        isLOading = true;
      });
      return botResponse;
    } else {
      // Request failed, handle error.
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    print("helloooooo");
    print("summary is $summary");

    print("above");
  }

  @override
  Widget build(BuildContext context) {
    if (isLOading) {
      return Scaffold(
          backgroundColor: Kbackgroundcolor,
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Kmainboard,
                  borderRadius: KMyborder,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Image.asset("assets/novo_logo1.png"),
                              ),
                              const Text("Enhanced Notes",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const Divider(
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: const Text("Click to Edit your notes!!",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 188, 187, 187))),
                          ),
                          Container(
                            height: 500,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: KMyborder,
                              color: Kgreycolor_light,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 5),
                              child: TextField(
                                controller: summarytextcontroller,
                                maxLength: null,
                                maxLines: null,
                                // Allow unlimited lines in the text field
                                decoration: const InputDecoration(
                                  border:
                                      InputBorder.none, // Remove default border
                                  hintText: 'Here...',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  _saveToFile(context);
                                },
                                child: Container(
                                    width: 145,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: const Color.fromARGB(
                                            255, 51, 51, 51)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Save to File",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.download_rounded,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              )));
    }
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
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
          const SnackBar(content: Text('Text saved to file')),
        );
      } catch (e) {
        print('Error saving to file: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving to file')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text')),
      );
    }
  }
}
