import 'package:flutter/material.dart';

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
  // const Notes(),
  // const UploadNotes(),
  // const Profile(),
];

late double hght;
late double wdth;
