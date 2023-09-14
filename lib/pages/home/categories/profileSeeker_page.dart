import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/yellowButton.dart';
import 'package:login_app/firebase/cloud_storage.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/pages/jobseeker/editProfileSeeker_page.dart';
// import 'package:login_app/test/auth/test_login_page.dart';
import 'package:login_app/variables.dart';

class ProfileSeeker extends StatefulWidget {
  const ProfileSeeker({super.key});

  @override
  State<ProfileSeeker> createState() => _ProfileSeekerState();
}

class _ProfileSeekerState extends State<ProfileSeeker> {

  final user = auth.currentUser!;
  
  @override
  Widget build(BuildContext context) {
    final Storage cloud = Storage();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: titleJobCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 13.0),
            Row(
              children: [
                FutureBuilder<String>(
                  future: cloud.handleImageURL(auth.currentUser?.uid),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      
                      if(snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      final imageURL = snapshot.data;
                      print(imageURL);
                      if(imageURL != null) {
                        return Container(
                          width: 50,
                          height: 50,
                          child: Image.network(imageURL),
                        );
                      } else {
                        print("masuk else sizedbox");
                        return const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.person_2_outlined,
                            color: titleContentColor,
                          ),
                        );
                      }
                    } 
                    else {
                      return const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.person_2_outlined,
                          color: titleContentColor,
                        ),
                      );
                    }
                  }
                ),
                const SizedBox(width: 17.0),
      
                // Username & email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.email!.substring(0, user.email!.length - 10),
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: titleContentColor,
                      )
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      user.email!,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: titleContentColor,
                      )
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 18),
            YellowButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => editProfileSeeker()),
                );
              },
              label: "Edit your profile"
            ),
            const SizedBox(height: 24.0),
            const Divider(
              color: Color(0xbffdadada),
              thickness: 0.5,
            ),
            const SizedBox(height: 24.0),
            YellowButton(
              label: "About enablind", 
              onPressed: () {},
            ),
            const SizedBox(height: 24.0),
            YellowButton(
              label: "Log out", 
              onPressed: () {},
            ),
          ],
        ),
      )
    );
  }
}