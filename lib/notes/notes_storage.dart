import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:uuid/uuid.dart';

Future<String> uploadPdf(String tags, String filePath, String subject,
    int likes, String filename, String author, sem) async {
  final storageRef = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance;

  try {
    final mountainsRef = storageRef.child("Notes");

    File file = File(filePath);

    await mountainsRef.putFile(file);

    final pdfText = getPdfText(filePath);
    const uuid = Uuid();

    String uid = uuid.v5(Uuid.NAMESPACE_OID, pdfText.toString());

    final url =
        await FirebaseStorage.instance.ref().child('Notes').getDownloadURL();
    print(url);

    firestore.collection("pdf").doc(uid).set({
      "author": author,
      "pdfurl": url,
      "likes": likes,
      "tags": tags,
      "subject": subject,
      "filename": filename,
      "semester": sem,
    });

    return "true";
  } catch (e) {
    return e.toString();
  }
}

Future<String> getPdfText(String path) async {
  String text = "";
  try {
    text = await ReadPdfText.getPDFtext(path);
    return text;
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
