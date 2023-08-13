import 'package:flutter/material.dart';
import 'package:notex/hackathon/explore_hackatho.dart';
import 'package:notex/internship/internship.dart';
import 'package:notex/notes/explore_notes.dart';
import 'package:notex/profile/profile.dart';

import '../notes/upload_notes.dart';

Color backgroundColor = Colors.amberAccent.shade200;

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(content)),
      duration: const Duration(seconds: 5),
    ),
  );
}

List<Widget> pages = [
  const ExploreNotes(),
  
  const ExploreHackathons(),
   InternshipPage(),
  const UploadNotes(),
  const Profile(),
];

late double hght;
late double wdth;

late final username;
late final semester;
late final branch;
