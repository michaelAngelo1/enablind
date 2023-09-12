import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/pages/jobseeker/editProfileSeeker_page.dart';
import 'package:login_app/variables.dart';

class ProfileSeeker extends StatefulWidget {
  const ProfileSeeker({super.key});

  @override
  State<ProfileSeeker> createState() => _ProfileSeekerState();
}

class _ProfileSeekerState extends State<ProfileSeeker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: titleJobCardColor,
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => editProfileSeeker()),
            );
          },
          child: Text(
            "Edit Profile"
          )
        )
      )
    );
  }
}