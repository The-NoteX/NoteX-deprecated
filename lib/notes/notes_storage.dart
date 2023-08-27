import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

final storageRef = FirebaseStorage.instance.ref();
final firestore = FirebaseFirestore.instance;

Future<String> uploadPdf(String tags, String filePath, String subject,
    int likes, String filename, String author, String sem) async {
  try {
    final mountainsRef = storageRef.child("Notes");

    File file = File(filePath);

    var upload =
        await mountainsRef.child('author').child('filename').putFile(file);
    const uuid = Uuid();
    var namespace = Uuid.NAMESPACE_URL;
    var url = await FirebaseStorage.instance
        .ref()
        .child('Notes')
        .child('author')
        .child('filename')
        .getDownloadURL();

    var urlSize = '$url?size=${upload.totalBytes}';

    var uid = uuid.v5(namespace, urlSize);

    firestore.collection("pdf").doc(uid).set({
      "author": author,
      "pdfurl": url,
      "likes": likes,
      "tags": tags,
      "subject": subject,
      "filename": filename,
      "semester": sem,
      "docid": uid,
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

Future<String> postComment(String comment, String docId) async {
  var url = Uri.parse("http://10.50.5.86:8000/model/?q=$comment");
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  var value = json['predict'];

  if (value == 1) {
    String commentId = const Uuid().v1();

    firestore
        .collection('pdf')
        .doc(docId)
        .collection("comments")
        .doc(commentId)
        .set({
      "comment": comment,
      "date": DateTime.now(),
    });

    return "true";
  } else {
    return "spam";
  }
}

Future likePost(String docId, bool liked, int likes) async {
  if (liked) {
    await firestore.collection('pdf').doc(docId).update({'likes': likes + 1});
  } else {
    await firestore.collection('pdf').doc(docId).update({'likes': likes - 1});
  }
}
