import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({super.key});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {

  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.arrow_back_rounded
            )
          )
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                saved = !saved;
              });
            },
            icon: saved ? Icon(Icons.bookmark) : Icon(Icons.bookmark_outline),
          ),
        ],
        backgroundColor: mainBgColor,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: mainBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 750,
                width: 500,
                decoration: BoxDecoration(
                  color: cardJobListColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  border: Border.all(color: accentColor)
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  // Job Vacancy Content
                  children: <Widget>[
                    const SizedBox(height: 30),

                    // Corp Logo
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          )
                        ),
                      )
                    ),
                    const SizedBox(height: 16.0),

                    Center(
                      child: Text(
                        "Product Designer",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffbf7f8f9),
                        )
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    Center(
                      child: Text(
                        "Atlassian",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffbf7f8f9),
                        )
                      ),
                    ),

                    
                  ]
                )
              )
            ]
          ),
        )
      ),
    );
  }
}