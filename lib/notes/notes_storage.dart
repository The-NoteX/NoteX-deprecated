import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadPdf(String childName, String filePath) async {
  final storageRef = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance;

  try {
    final mountainsRef = storageRef.child("Notes");

    File file = File(filePath);

    await mountainsRef.putFile(file);

    final url =
        await FirebaseStorage.instance.ref().child('Notes').getDownloadURL();

    firestore.collection("users").doc("pdf").set({
      "pdfurl": url,
    });

    return "true";
  } catch (e) {
    return e.toString();
  }
}

Future<String?> pickFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    String filePath = result.files.first.path!;

    return filePath;
  }
  return "done";
}
