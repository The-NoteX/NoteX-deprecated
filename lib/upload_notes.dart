import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/utils/constants.dart';
// import '../resources/auth_method.dart';
import 'package:notex/notes/notes_storage.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes({super.key});

  @override
  State<UploadNotes> createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  int _tag = 0;
  final TextEditingController _subject = TextEditingController();

  void onButtonPressed(int index) {
    setState(() {
      _tag = index;
    });
  }

  Future<String?> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String filePath = result.files.first.path!;
      print("${result.files.first.name}.pdf");
      return filePath;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
// appbar

    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56.5),
      child: AppBar(
        title: Container(
          alignment: const Alignment(-0.25, -0.9),
          child: Text(
            "Upload Notes",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        toolbarHeight: 56.5,
        leading: IconButton(
          iconSize: 24.5,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
      ),
    );

    // List of Courses
    List<String> tags = ["CSE", "ECE", "Dev"];

    List<Widget> tagsButton = List.generate(
      tags.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: ElevatedButton(
            onPressed: () {
              onButtonPressed(index + 1);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(70, 50),
              foregroundColor: _tag == index + 1 ? Colors.white : Colors.black,
              backgroundColor: _tag == index + 1 ? Colors.black : Colors.white,
            ),
            child: Text(
              tags[index],
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w600,
                fontSize: _tag == index + 1 ? 18 : 13,
              ),
            ),
          ),
        );
      },
    );
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 25, right: 25),
        child: ListView(
          children: [
            // tag

            Text("Select Tags", style: GoogleFonts.manrope(fontSize: 25)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: tagsButton),
            ),
            const SizedBox(height: 75),

            // subject

            Text(
              "Name",
              softWrap: true,
              style: GoogleFonts.manrope(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _subject,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.justify,
              scrollPhysics: const BouncingScrollPhysics(),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                constraints: const BoxConstraints(
                  minHeight: 50,
                  maxHeight: 100,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                hintText: "Discrete Mathematics ",
                labelStyle: const TextStyle(color: Colors.blue),
              ),
            ),

            const SizedBox(height: 25),

            // file browse

            Center(
              child: InkWell(
                onTap: () async {
                  if (_subject.text.trim().isEmpty) {
                    showSnackBar(context, "Plz enter a subject");
                  } else if (_tag == 0) {
                    showSnackBar(context, "Plz select a tag");
                  } else {
                    String? filePath = await pickFiles();
                    print("$filePath 2");
                    await uploadPdf("our pdfs", filePath!);
                  }
                },
                child: const FaIcon(
                  FontAwesomeIcons.fileArrowUp,
                  size: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
