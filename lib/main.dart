import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resumer/resumeChecker.dart';











void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resumer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Resumer'),
    );
  }
}







class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController desc=new TextEditingController();
  List data=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children : [
          GestureDetector(
          child: Container(height: 100,width: 100,color: Colors.black,
            child: Icon(Icons.add,color: Colors.white,),
          ),
          onTap: ()async{
            print("taped");
            FilePickerResult? result= await FilePicker.platform.pickFiles();
            if(result!=null) {
              PlatformFile? file = result.files.first;
              print(file.path);
              final File fileFor = File(file.path??"");
              data=[];
              fileFor.readAsString().asStream().listen((event) {
                data.add(event.toLowerCase());
              });
              // List<File> files= result.paths.map((e) => File(e)).toList();
            }
          },
        ),
          ElevatedButton(onPressed: (){
            bool x= ResumeChecker().acceptOrReject(data, desc.text);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${x?'Agree':'Reject'}")));
          }, child: Text("submit")),
          Container(
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: desc,
                ),
                ElevatedButton(onPressed: (){

                }, child: Text("save"))
              ],
            ),
          )

      ]
      )
    );
  }
}
