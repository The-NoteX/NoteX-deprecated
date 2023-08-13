import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/constants.dart';

class InternshipPage extends StatelessWidget {
  PreferredSize appBar = PreferredSize(
    preferredSize: const Size.fromHeight(56.5),
    child: AppBar(
      title: Container(
        alignment: const Alignment(-0.2, -0.9),
      ),
      toolbarHeight: 56.5,
      backgroundColor: backgroundColor,
      shadowColor: Colors.transparent,
    ),
  );

  InternshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Explore Internships',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        forceMaterialTransparency: true,
        toolbarHeight: 70,
      ),
        body: InternshipCard(),
      ),
    );
  }
}

class InternshipCard extends StatelessWidget {
  final List<InternshipWebsite> internshipWebsites = [
    InternshipWebsite(
        "Internshala", "https://internshala.com/", "internshala_logo_url"),
    InternshipWebsite(
        "LinkedIn", "https://www.linkedin.com", "linkedin_logo_url"),
    InternshipWebsite("Indeed", "https://www.indeed.com",
        "https://prod.statics.indeed.com/eml/assets/images/logo/indeed_logo_1200x630.png"),
    // Add more internship websites here
  ];

  InternshipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          for (var website in internshipWebsites)
            GestureDetector(
              onTap: () {
                launchURL(website.url);
              },
              child: Container(
                margin: const EdgeInsets.all(20), // Add margin between list items
                padding: const EdgeInsets.all(50.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 223, 223),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                child: Center(
                  child: Text(
                    website.name,
                    style: GoogleFonts.manrope(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class InternshipWebsite {
  final String name;
  final String url;
  final String logoUrl;

  InternshipWebsite(this.name, this.url, this.logoUrl);
}
