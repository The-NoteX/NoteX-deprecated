import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:notex/notes/comment.dart';
import 'package:notex/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfBox extends StatefulWidget {
  final dynamic snap;
  const PdfBox({
    super.key,
    required this.snap,
  });

  @override
  State<PdfBox> createState() => _PdfBoxState();
}

bool _liked = false;

class _PdfBoxState extends State<PdfBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          color: const Color.fromARGB(255, 233, 233, 233),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            // subject

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.snap['subject'],
                style: GoogleFonts.manrope(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 5),

            // author

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "~${widget.snap['author']}",
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                // tag

                Container(
                  alignment: Alignment.centerLeft,
                  width: 90,
                  height: 45,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Center(
                    child: Text(
                      widget.snap['tags'],
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // semester

                Padding(
                  padding: const EdgeInsets.only(left: 105),
                  child: Text(
                    "Semester ${widget.snap['semester']}",
                    style: GoogleFonts.manrope(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // view pdf

                GestureDetector(
                  onTap: () {
                    launchUrl(
                      Uri.parse(widget.snap['pdfurl']),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Center(
                      child: Text(
                        "View PDF",
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),
                // icons

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        Share.share(widget.snap['pdfurl']);
                      },
                      icon: Icon(MdiIcons.send),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Comments(snap: widget.snap),
                          ),
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.comment),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.download),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _liked = !_liked;
                            });
                          },
                          icon: _liked
                              ? const Icon(FontAwesomeIcons.solidThumbsUp)
                              : const Icon(FontAwesomeIcons.thumbsUp),
                        ),
                        Text(widget.snap['likes'].toString())
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
