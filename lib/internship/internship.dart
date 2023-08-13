
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart'; // Import the url_launcher package


class InternshipPage extends StatelessWidget {



  final List<InternshipWebsite> internshipWebsites = [
    InternshipWebsite("Internshala", "https://internshala.com/"),
    InternshipWebsite("LinkedIn", "https://www.linkedin.com"),
    InternshipWebsite("Indeed", "https://www.indeed.com"),
    
  ];

  @override
  Widget build(BuildContext context) {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar,
        body: InternshipList(internshipWebsites),
      ),
    );
  }
}

class InternshipWebsite {
  final String name;
  final String url;

  InternshipWebsite(this.name, this.url);
}

class InternshipList extends StatelessWidget {
  final List<InternshipWebsite> internshipWebsites;

  InternshipList(this.internshipWebsites);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: internshipWebsites.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(internshipWebsites[index].name),
          onTap: () {
            launchURL(Uri.parse('internshipWebsites[index]'));
          },
        );
      },
    );
  }

  void launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
