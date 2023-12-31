import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:login_app/components/buttons/bottomButton.dart';
import 'package:login_app/firebase/cloud_storage.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/variables.dart';
import 'package:intl/intl.dart';

class editProfileCorp extends StatefulWidget {
  const editProfileCorp({super.key});

  @override
  State<editProfileCorp> createState() => _editProfileCorpState();
}

class _editProfileCorpState extends State<editProfileCorp> {

  final _fullNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final editJobseekerRef = fsdb.collection('Users/Role/Corporations').doc(auth.currentUser!.uid);

  @override

  void initState() {
    super.initState();
    // Fetch data from Firestore and populate the text controllers
    editJobseekerRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _fullNameController.text = data['corporationName'] ?? '';
          
            // Check if 'dateOfBirth' is already a string or a timestamp
          final dynamic dobData = data['foundingDate'];
          if (dobData is String) {
            // 'dateOfBirth' is already a string
            _dobController.text = dobData;
          } else if (dobData is Timestamp) {
            // 'dateOfBirth' is a timestamp, so convert it to a human-readable date format
            final timestamp = dobData as Timestamp;
            final dob = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
            _dobController.text = DateFormat('yyyy-MM-dd').format(dob); // You can change the date format as needed
          }

          _phoneNumberController.text = data['phoneNumber'] ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Storage cloud = Storage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundTemplate(
        title: "Profile",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                              color: accentColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
              
                  Container(
                      width: 500,
                      height: 600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          
                          HelperText(helper: "Corporation Name"),
                          const SizedBox(height: 12.0),
                          EditProfileField(fieldController: _fullNameController),
              
                          HelperText(helper: "Founding Date"),
                          const SizedBox(height: 12.0),
                          EditProfileField(fieldController: _dobController),
              
                          HelperText(helper: "Phone Number"),
                          const SizedBox(height: 12.0),
                          EditProfileField(fieldController: _phoneNumberController),

                          BottomButton(
                            label: "Apply edit", 
                            onPressed: () {
                              editJobseekerRef.update({
                                'corporationName': _fullNameController.text,
                                'foundingDate': _dobController.text,
                                'phoneNumber': _phoneNumberController.text,
                              })
                                .then((value) => print("Edit profile success"), onError: (e) => print("Error edit profile"));
                              Navigator.pop(context);
                            },
                          )
                      ]
                    )
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class EditProfileField extends StatelessWidget {
  final TextEditingController fieldController;
  const EditProfileField({
    super.key,
    required this.fieldController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextField(
        controller: fieldController,
        obscureText: false,
        decoration: InputDecoration(
          fillColor: disabledNavbar.withOpacity(0.5),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        )
      ),
    );
  }
}

class HelperText extends StatelessWidget {
  final String helper;
  const HelperText({
    super.key,
    required this.helper,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(helper,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: titleContentColor
          )
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.transparent,
          )
        )
      ],
    );
  }
}