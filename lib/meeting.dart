import 'package:camera/camera.dart';
import "package:flutter/material.dart";
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
  String pdffile = '';
  Meeting({super.key, required this.pdffile});

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  String pdffile = '';
  late String formattedTime;
  int cameraside = 1;
  String finaltext = "hello";
  String works_text = '';
  final TextEditingController _textController =
      TextEditingController(); //creating object for the class
  final String _filePath = '';
  List<String> List_text = [];
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  final String _lastWords = '';
  bool _isListening = false;
  List<String> uniqueSentences = [];
  String lastRecognizedWords = '';
  String livewords = "";

  @override
  void initState() {
    //initSpeech();

    super.initState();
    _initSpeech();
    micon = false;
    DateTime now = DateTime.now();

    // Format the current time as a string (HH:mm:ss)
    formattedTime = "${now.hour}:${now.minute}:${now.second}";
    try {
      cameraController =
          CameraController(cameras[cameraside], ResolutionPreset.ultraHigh);
      cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case "CameraAccessDenied":
              print("User denied camera access.");
              showErrorDialog(context, "User denied camera access.");
              break;
            default:
              print("handle other errors.");
              showErrorDialog(context,
                  "An error occurred: ${e.code}\nTry restrating the app");
              break;
          }
        }
      });
    } catch (e) {
      print("no camera is found in the computer, $e");
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
          localeId: 'en-UK',
        );
      }
    }
    setState(() {
      _isListening = true;
      _startListening();
    });
  }

  void _stopListening() async {
    if (_isListening) {
      _isListening = false;
      await _speechToText.stop();
      setState(() {});
    }
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
        _textController.text = uniqueSentences.join(' ');
        finaltext =
            uniqueSentences.join(' '); //contains whole teachers transcript
        print("===============================$finaltext");
      });
      setState(() {});

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
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Kmainboard,
                  borderRadius: KMyborder,
                ),
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
                          const Text(" Meeting",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600)),
                        ],
                      ),

                      const Divider(
                        indent: 0,
                        endIndent: 0,
                      ),

                      //video container
                      if (!cameraController.value.isInitialized)
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "If it take time try restarting the app",
                                    style: Kcommontextstyle,
                                  ),
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
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: yes
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: const Color.fromARGB(
                                                      255, 186, 186, 186)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: ClipRect(
                                                          child: Image.asset(
                                                        "assets/No_camera.png",
                                                        height: 300,
                                                      ))),
                                                  Text("Your Camera is off!",
                                                      style: Kcommontextstyle)
                                                ],
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: ClipRect(
                                                      child: CameraPreview(
                                                          cameraController))))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        color: const Color.fromARGB(
                                            255, 226, 226, 226),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(livewords,
                                          style: const TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      const SizedBox(
                          height: 30), //HERE THE VIDEO CONTAINER SHOUL BE THERE
                      Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "$formattedTime | xhdy-123",
                                    style: const TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              _isListening
                                                  ? _stopListening()
                                                  : _startListening();
                                              setState(() {
                                                micon = !micon;
                                                if (micon == true) {
                                                  _startListening();
                                                } else if (micon == false) {
                                                  _stopListening();
                                                }
                                              });
                                            },
                                            child: micon
                                                ? const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    radius: 30,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.mic,
                                                      size: 35,
                                                      color: Colors.white,
                                                    )))
                                                : const CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    radius: 30,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.mic_off,
                                                      size: 35,
                                                      color: Colors.white,
                                                    )))),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                yes = !yes;
                                                cameraon = !cameraon;
                                              });
                                            },
                                            child: cameraon
                                                ? const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    radius: 30,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.camera_alt,
                                                      size: 35,
                                                      color: Colors.white,
                                                    )))
                                                : const CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    radius: 30,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.camera_alt,
                                                      size: 35,
                                                      color: Colors.white,
                                                    )))),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                        Center(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  backgroundColor: Colors.red,
                                                  minimumSize:
                                                      const Size(115, 65),
                                                  maximumSize:
                                                      const Size(135, 65),
                                                  disabledForegroundColor:
                                                      const Color.fromARGB(
                                                              255, 0, 0, 0)
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      const Color.fromARGB(
                                                              255, 245, 15, 15)
                                                          .withOpacity(0.12),
                                                ),
                                                onPressed: () {
                                                  _stopListening();

                                                  //ONPREWSED
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Summary(
                                                                summary:
                                                                    "$livewords \n\n\n $referencetext",
                                                                pdffile:
                                                                    pdffile,
                                                              )));
                                                },
                                                child: const Text(
                                                  "END",
                                                  style: TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ))),
                                      ],
                                    ),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  /*  Navigator.pop(context);
                                 Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Upload()));*/
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 198, 198, 198)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                            "Edit the reference Material")),
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
