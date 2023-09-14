import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:login_app/firebase/cloud_storage.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/variables.dart';

class editProfileSeeker extends StatefulWidget {
  const editProfileSeeker({super.key});

  @override
  State<editProfileSeeker> createState() => _editProfileSeekerState();
}

class _editProfileSeekerState extends State<editProfileSeeker> {
  String? _imageURL;
  @override
  Widget build(BuildContext context) {
    final Storage cloud = Storage();
    return BackgroundTemplate(
      title: "Profile",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  FutureBuilder<String>(
                      future: cloud.handleImageURL(auth.currentUser?.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          final imageURL = snapshot.data;
                          print(imageURL);
                          if (imageURL != null) {
                            return Container(
                              width: 80,
                              height: 80,
                              child: Image.network(imageURL),
                            );
                          } else {
                            print("masuk else sizedbox");
                            return const CircularProgressIndicator();
                          }
                        } else {
                          return const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: titleContentColor,
                            ),
                          );
                        }
                      }),
                  const SizedBox(width: 14.0),
                  TextButton(
                    // UPLOAD IMAGE PROCESSING
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg', 'jpeg'],
                      );

                      if (results == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No file selected"),
                          ),
                        );
                        return null;
                      }

                      final path = results.files.single.bytes;

                      // GET UID CURRENTLY LOGGED IN USER
                      final uidAsFilename = auth.currentUser?.uid;

                      cloud.handleUploadPhoto(path, uidAsFilename);

                      // setState(() {
                      //   _imageURL = uploaded as String;
                      // });
                    },
                    child: Text("change profile picture",
                        style: GoogleFonts.plusJakartaSans(
                          color: titleContentColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // GET IMAGE URL
              Container(
                  width: 330,
                  height: 90,
                  child: Column(children: <Widget>[
                    Text("Full name",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: titleContentColor)),
                    const SizedBox(height: 12.0),
                    Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: disabledNavbar,
                          borderRadius: BorderRadius.circular(12),
                        ))
                  ]))
            ]),
      ),
    );
  }
}
