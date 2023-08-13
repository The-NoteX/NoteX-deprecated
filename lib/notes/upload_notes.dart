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
  String _tag = "";
  int _sem = 0;
  String? _fileName;
  String? filePath;
  bool _isSelected = false;
  final TextEditingController _subject = TextEditingController();

  void onButtonPressed(String index) {
    setState(() {
      _tag = index;
    });
  }

  void onButtonPressed1(int index) {
    setState(() {
      _sem = index;
    });
  }

  Future<String?> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String filePath = result.files.first.path!;
      _fileName = result.files.first.name;
      return filePath;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // List of Courses

    List<String> tags = ["CSE", "ECE"];

    List<Widget> tagsButton = List.generate(
      tags.length,
      (index) {
        return ElevatedButton(
          onPressed: () {
            onButtonPressed(tags[index]);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(width: 1)),
            foregroundColor: _tag == tags[index] ? Colors.white : Colors.black,
            backgroundColor: _tag == tags[index] ? Colors.black : Colors.white,
          ),
          child: Text(
            tags[index],
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w400,
              fontSize: _tag == tags[index] ? 20 : 15,
            ),
          ),
        );
      },
    );

    List<String> buttonsText = [
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
    ];

    List<Widget> buttons = List.generate(
      buttonsText.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: ElevatedButton(
            onPressed: () {
              onButtonPressed1(index + 1);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(width: 1)),
              foregroundColor: _sem == index + 1 ? Colors.white : Colors.black,
              backgroundColor: _sem == index + 1 ? Colors.black : Colors.white,
            ),
            child: Text(
              buttonsText[index],
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w600,
                fontSize: _sem == index + 1 ? 20 : 13,
              ),
            ),
          ),
        );
      },
      growable: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Upload Notes',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
        child: ListView(
          children: [
            // tag

            Text(
              "Name",
              softWrap: true,
              style: GoogleFonts.manrope(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),

            // TextFormField(
            //   controller: _subject,
            //   keyboardType: TextInputType.text,
            //   textAlign: TextAlign.justify,
            //   scrollPhysics: const BouncingScrollPhysics(),
            //   style: const TextStyle(color: Colors.black),
            //   decoration: InputDecoration(
            //     constraints: const BoxConstraints(
            //       minHeight: 50,
            //       maxHeight: 100,
            //     ),
            //     fillColor: Colors.white,
            //     filled: true,
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(100)),
            //     hintText: "Discrete Mathematics ",
            //     labelStyle: const TextStyle(color: Colors.blue),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(width: 1)),
                ),
                child: TextFormField(
                  controller: _subject,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.justify,
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(
                      minHeight: 50,
                      maxHeight: 100,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    hintText: "  janedoe_12;",
                    labelStyle: TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            Text(
              "Select Tags",
              style: GoogleFonts.manrope(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Wrap(spacing: 20, children: tagsButton),
              ),
            ),

            // subject

            const SizedBox(height: 40),

            Container(
              alignment: const Alignment(-0.7, -1),
              child: Text(
                "Semester",
                style: GoogleFonts.manrope(
                  fontSize: wdth * 0.1,
                  fontWeight: FontWeight.w300,
                ),
                softWrap: true,
              ),
            ),
            const SizedBox(height: 5),

            // sem button

            Center(child: Wrap(children: buttons)),
            const SizedBox(height: 40),

            // file browse

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [InkWell(
                  onTap: () async {
                    if (_subject.text.trim().isEmpty) {
                      showSnackBar(context, "Plz enter a subject");
                    } else if (_tag.isEmpty) {
                      showSnackBar(context, "Plz select a tag");
                    } else {
                      filePath = await pickFiles();
                      if (filePath!.isNotEmpty) {
                        setState(() {
                          _isSelected = true;
                        });
                      }
                    }
                  },
                  child: _isSelected
                      ? const FaIcon(
                          FontAwesomeIcons.fileCircleCheck,
                          size:30,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.fileArrowUp,
                          size: 30,
                        ),
                ),
              const SizedBox(height: 30),
            
              // upload
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: InkWell(
                  overlayColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 88, 245, 245),
                  ),
                  borderRadius: BorderRadius.circular(50),
                  onTap: () async {
                    String uploaded = await uploadPdf(
                      _tag.toString(),
                      filePath!,
                      _subject.text,
                      0,
                      _fileName.toString(),
                      username,
                      _sem.toString(),
                    );
            
                    if (uploaded == "true") {
                      // ignore: use_build_context_synchronously
                      showSnackBar(context, "Uploaded");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(FontAwesomeIcons.upload),
                        const SizedBox(width: 15),
                        Text(
                          "Upload",
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),]),
            ),
          ],
        ),
      ),
    );
  }
}
