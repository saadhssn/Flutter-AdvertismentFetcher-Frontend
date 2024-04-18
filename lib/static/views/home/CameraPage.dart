import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../dropdown_model.dart';


class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? path;       // Saad
  const MyHomePage({Key? key, this.path}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isOpen = false;
  String selectOption = 'Select Option';
  //List<String> politicsList = ['Car', 'House', 'Accessories', 'Watches', 'Others'];
  List<DropdownModel> dropdownData = []; // New list to hold API data

  bool showImage = false;
  bool isloading = false;
  bool _isVisible = true;
  String dropdownValue = "One";
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the API function when the widget is initialized
    getPost().then((data) {
      dropdownData = data;
    });
  }

  Future<List<DropdownModel>> getPost () async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.1.105:8080/api/category'));
      final body = json.decode(response.body) as List;

      if(response.statusCode == 200){
        return body.map((e) {
          final map = e as Map<String, dynamic> ;
          return DropdownModel(
            id: map['id'],
            name: map['name'],
          );
        }).toList();
      }
    }on SocketException{
      throw Exception('No Internet');
    }
    throw Exception('Error fetching data');
  }

  @override
  void disposeImage() {
    setState(() {
      //_isVisible = false;
      imageFile = null;
      showImage = false;
    });
  }

  void toggleImageVisibility() {
    setState(() {
      showImage = !showImage;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scan Text"),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    child:
                    (imageFile != null) ? Image.file(File(imageFile!.path)) : Text(""),
                    width: 300,
                    height: 10,
                    color: Colors.white24!,
                  ),
                if(!showImage)
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          1000,
                          400,
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.grey,
                        shadowColor: Colors.grey[400],
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.center_focus_weak,
                              size: 300,
                            ),
                            Text(
                              "Scan Image",
                              style: TextStyle(
                                  fontSize: 24, color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                      //child: const Text('Modal Bottom Sheet'),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 140,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                            width: 500,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            margin: const EdgeInsets.symmetric(horizontal: 5),
                                            padding: const EdgeInsets.only(top: 10),
                                            child: GestureDetector(
                                              //margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                              onTap: () {
                                                getImage(ImageSource.gallery);
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                    size: 30,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 10),
                                                    child: Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                          fontSize: 13, color: Colors.grey[600]),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        padding: const EdgeInsets.only(top: 0),
                                        child: GestureDetector(
                                          //margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                          onTap: () {
                                            getImage(ImageSource.camera);
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                size: 30,
                                              ),
                                              Text(
                                                "Camera",
                                                style: TextStyle(
                                                    fontSize: 13, color: Colors.grey[600]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                    ),
                  ),
                SizedBox(height: 20),
                if(showImage)
                  Stack(
                      children: [
                        Visibility(
                          visible: _isVisible,
                          child:
                          (imageFile != null && _isVisible) ? Image.file(File(imageFile!.path)) : Text(""),
                        ),
                        /*Container(
                      child:
                        (imageFile != null && isImageVisible) ? Image.file(File(imageFile!.path)) : Text(""),
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),*/
                        Positioned(
                          right: 10,
                          top: 10,
                          child: GestureDetector(
                            onTap: disposeImage, // Toggle image visibility
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30, // Customize the close button size as needed
                            ),
                          ),
                        ),
                      ]
                  ),
                Container(
                  child: Text(
                    scannedText,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 100000000000,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: "Text goes here..."
                    ),
                  ),
                ),
                SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            isOpen = !isOpen;
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15,
                                  offset: Offset(0, 28),
                                  spreadRadius: -20,
                                ),
                              ],
                              color: Colors.white38,
                              border: Border.all(
                                color: Colors.black87,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectOption,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (isOpen)
                          Container(
                            width: 500,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: dropdownData.map((e) => Container(
                                  color: selectOption == e.name ? Colors.grey.shade300 : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              e.name.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: selectOption == e.name ? Colors.black : Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        selectOption = e.name.toString();
                                        isOpen = false;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isloading = true;
                        });
                        Future.delayed(Duration(seconds: 3), (){
                          setState(() {
                            isloading = false;
                          });
                        });
                      },
                      child: isloading ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Loading...', style: TextStyle(fontSize: 20),),
                          SizedBox(width: 10,),                          CircularProgressIndicator(color: Colors.white,),
                        ],
                      ) : const Text('Submit', style: TextStyle(fontSize: 20),)),
                ),
                SizedBox(height: 20),
              ],
            )),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        showImage = true;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      showImage = false;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = TextRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock text in recognisedText.blocks) {
      for (TextLine line in text.lines) {
        //scannedText = scannedText + line.text + "\n";
        controller.text = recognisedText.text;
      }
    }
    textScanning = false;
    setState(() {});
  }

}