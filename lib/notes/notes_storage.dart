import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadPdf(String childName, String filePath) async {
  final storageRef = FirebaseStorage.instance.ref();

  final mountainsRef = storageRef.child("Notes");

  File file = File(filePath);

  await mountainsRef.putFile(file);

  return "true";
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
  return null;
}
