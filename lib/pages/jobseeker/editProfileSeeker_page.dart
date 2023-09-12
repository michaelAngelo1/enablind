import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:login_app/firebase/cloud_storage.dart';

class editProfileSeeker extends StatefulWidget {
  const editProfileSeeker({super.key});

  @override
  State<editProfileSeeker> createState() => _editProfileSeekerState();
}

class _editProfileSeekerState extends State<editProfileSeeker> {
  @override
  Widget build(BuildContext context) {
    final Storage cloud = Storage();
    return BackgroundTemplate(
        title: "Profile",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              // UPLOAD IMAGE PROCESSING
              onPressed: () async {
                print("masuk onpressed");
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg', 'jpeg'],
                );

                if(results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No file selected"),
                    ),
                  );
                  return null;
                }

                final path = results.files.single.bytes;
                final fileName = results.files.single.name;

                print(path);
                print(fileName);

                cloud.uploadPhoto(path, fileName);

              },
              child: Text("Upload Image"),
            )
          ]
        ), 
    );
  }
}