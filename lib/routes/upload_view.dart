import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'dart:io';
import 'dart:async';


//TODO: implement upload view

class UploadView extends StatefulWidget {
  const UploadView({Key? key}) : super(key: key);

  @override
  State<UploadView> createState() => _UploadViewState();
}



class _UploadViewState extends State<UploadView> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async{

    final result = await FilePicker.platform.pickFiles();
    if (result == null) {


      return;
    }

    setState((){
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async{
    final path = 'Images/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState((){
      pickedFile = null;
    });


  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Post",
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            if (pickedFile != null)
              Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
              ),

            if(pickedFile == null)
              Container(
                child: ElevatedButton(
                  child: Image.asset('assets/icons/add_icon.png', fit: BoxFit.cover,),
                  onPressed: selectFile,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                  ),
                ),
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 4, color: AppColors.primary)
                ),

              ),

            Divider(
              color: Colors.grey.shade300,
              height: 30,
              thickness: 1.3,
              indent: 5,
              endIndent: 5,
            ),

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Caption",
                labelStyle: kLabelStyle,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Enter Caption",
                hintStyle: kHint2LabelStyle,
              ),
            ),

            SizedBox(
              height: 30,
            ),

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Location",
                labelStyle: kLabelStyle,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Enter Location",
                hintStyle: kHint2LabelStyle,
              ),
            ),

            SizedBox(
              height: 80,
            ),

            Container(
              child: ElevatedButton(
                child: Icon(Icons.upload_rounded, color: AppColors.primary, size: 50,),
                onPressed: uploadFile,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.transparent,
                ),
              ),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3, color: AppColors.primary)
              ),

            ),

          ],

        )
      ),
    );
}

