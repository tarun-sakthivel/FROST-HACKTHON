import 'dart:convert';

import "package:flutter/material.dart";
import "package:meet_interface/welcomepage.dart";
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  final TextEditingController _referencetextcontroller =
      TextEditingController();
  String? _fileName;
  FilePickerResult? result;
  PlatformFile? pickedfile;
  bool isLOading = false;
  File? fileToDisplay;
  String pathofFile = '';
  List pickedfiles = [];
  String base64String = '';
  String manual_text =
      "'Projectile motion refers to the motion of an object that is projected into the air and then allowed to move under the influence of gravity. It is a classic example of two-dimensional motion. During projectile motion, the object follows a curved path known as a trajectory. The trajectory consists of two components: horizontal motion and vertical motion. The horizontal motion remains constant, while the vertical motion is influenced by gravity. The object reaches its maximum height at the peak of its trajectory before descending back to the ground. The time of flight, maximum height, and range of the projectile can be calculated using specific equations derived from the principles of kinematics. Projectile motion is utilized in various real-world scenarios, such as sports, engineering, and physics experiments. Understanding projectile motion is essential for predicting the behavior of objects in flight and designing effective systems and structures';";
  void pickFile() async {
    try {
      setState(() {
        isLOading = true;
      });

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

      setState(() {
        isLOading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  openFile(File) {
    OpenFile.open(File.path);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  //speech to text part

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                              //Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Welcomepage()));
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                          child: Image.asset("assets/novo_logo1.png"),
                        ),
                        const Text(" Uploads",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const Divider(
                      indent: 0,
                      endIndent: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        child: Row(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                  "Upload the reference text for notes generation"),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 400.0, width: 580,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 237, 237, 237),
                                ), // Set the desired height
                                child: TextField(
                                  controller: _referencetextcontroller,
                                  style: const TextStyle(),
                                  maxLines:
                                      null, // Allows for an unlimited number of lines
                                  decoration: const InputDecoration(
                                    hintText: 'Place the reference text here',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, bottom: 25.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          referencetext =
                                              _referencetextcontroller.text;
                                          print(
                                              "=========================REFERENE TEXT IS ============================\n$referencetext");
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Meeting(
                                                        pdffile: base64String,
                                                      )));
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Color.fromARGB(
                                                  255, 36, 232, 22)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text("Start Meeting",
                                                    style: TextStyle(
                                                        fontFamily: "inter",
                                                        fontSize: 20,
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(60, 50),
                                              maximumSize: const Size(210, 55),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 106, 255)),
                                          onPressed: () {
                                            pickFile();
                                          },
                                          child: const Text(
                                            "upload file",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                    ]),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 80, top: 5),
                            child: Image(
                              image: AssetImage("assets/reference.png"),
                              height: 420.11,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    if (pickedfile != null)
                      pickedfiles.isNotEmpty
                          ? Container(
                              child: Row(
                                children: [
                                  const Icon(Icons.picture_as_pdf),
                                  Text(
                                    'File: ${pickedfile!.path}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                  ],
                ),
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
        title: const Text("Error"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

class TextContainer extends StatelessWidget {
  final String finaltext;

  const TextContainer({super.key, required this.finaltext});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(finaltext, style: const TextStyle(fontSize: 50)),
    );
  }
}

returnLogo(file) {
  var ex = extension(file.path);
  if (ex == 'ppt') {
    return const Icon(Icons.pause_presentation);
  }
  if (ex == 'pdf') {
    return const Icon(Icons.picture_as_pdf);
  }
}
