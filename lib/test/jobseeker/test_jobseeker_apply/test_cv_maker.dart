import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/buttons/bottomButton.dart';
import 'package:login_app/variables.dart';

class CvTemplate extends StatefulWidget {
  final Map<String, dynamic> jobListing;
  final String role;

  const CvTemplate({Key? key, required this.jobListing, required this.role})
      : super(key: key);

  @override
  CvTemplateState createState() => CvTemplateState();
}

class CvTemplateState extends State<CvTemplate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  List<String> previousEducation = [];
  List<String> workExperience = [];

  // Method to submit the form data to Firestore
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Access the jobListing from the widget's parameters
      final Map<String, dynamic> jobListing = widget.jobListing;

      try {
        // Get the current user's UID
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          print("user null");
          return;
        }
        String uid = user.uid;

        // Create a Firestore document with the data
        await FirebaseFirestore.instance.collection('JobApplications').add({
          'uidUser': uid,
          'uidCorporate': jobListing['jobCompany'],
          'fullName': _fullNameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'summary': _summaryController.text,
          'education': previousEducation,
          'experience': workExperience,
          'status': 1,
          'role': widget.role,
          'timestamp': DateTime.now(), // Add a timestamp
        });

        // Optionally, you can show a success message or navigate to a new page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application submitted successfully!'),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        print('Error submitting form: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTemplate(
      title: 'CV Maker',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: 24,
                  ),
                  child: const HelperText(helper: "Full name")),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: MessageField(
                  fieldController: _fullNameController,
                  height: 70,
                  hintText: 'Name',
                  maxLines: 1,
                  expands: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const HelperText(helper: "Email")),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: MessageField(
                  fieldController: _emailController,
                  height: 70,
                  hintText: 'Email',
                  maxLines: 1,
                  expands: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    // You can add more email validation logic here
                    return null;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const HelperText(helper: "Active phone number")),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: MessageField(
                  fieldController: _phoneController,
                  height: 70,
                  hintText: 'Phone',
                  maxLines: 1,
                  expands: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    // You can add more email validation logic here
                    return null;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const HelperText(helper: "House Address")),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: MessageField(
                  fieldController: _addressController,
                  height: 70,
                  hintText: 'Address',
                  maxLines: 1,
                  expands: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    // You can add more email validation logic here
                    return null;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const HelperText(helper: "Summary")),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: MessageField(
                  fieldController: _summaryController,
                  height: 120,
                  hintText: 'Summary',
                  maxLines: 4,
                  expands: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your summary';
                    }
                    // You can add more email validation logic here
                    return null;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const HelperText(helper: "Education")),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: MessageField(
                  fieldController: _educationController,
                  height: 120,
                  hintText: 'Education (comma-separated)',
                  maxLines: 4,
                  expands: false,
                  onChanged: (value) {
                    previousEducation = value!.split(',');
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your education';
                    }
                    // You can add more email validation logic here
                    return null;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const HelperText(helper: "Experience")),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: MessageField(
                  fieldController: _experienceController,
                  height: 120,
                  hintText: 'Experience (comma-separated)',
                  maxLines: 4,
                  expands: false,
                  onChanged: (value) {
                    workExperience = value!.split(',');
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your experience';
                    }
                    // You can add more email validation logic here
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BottomButton(
                  label: 'Send',
                  onPressed: () {
                    _submitForm();
                  })
            ],
          ),
        ),
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
                color: titleContentColor)),
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.transparent,
            ))
      ],
    );
  }
}

class MessageField extends StatelessWidget {
  final TextEditingController fieldController;
  final double height;
  final String hintText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final int? maxLines;
  final bool expands;

  const MessageField({
    super.key,
    required this.fieldController,
    required this.height,
    required this.hintText,
    required this.validator,
    required this.maxLines,
    required this.expands,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        controller: fieldController,
        obscureText: false,
        maxLines: maxLines,
        onChanged: onChanged,
        expands: expands,
        validator: validator,
        decoration: InputDecoration(
          hintMaxLines: 12,
          fillColor: disabledNavbar.withOpacity(0.5),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(
                  0xFF334155), // Ubah warna atau atur BorderSide sesuai keinginan Anda
            ),
          ),
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFCC636), width: 4)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        ),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
