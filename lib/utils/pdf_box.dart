import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/utils/constants.dart';

class PdfBox extends StatefulWidget {
  final snap;
  const PdfBox({
    super.key,
    required this.snap,
  });

  @override
  State<PdfBox> createState() => _PdfBoxState();
}

class _PdfBoxState extends State<PdfBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 223, 223),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.snap['subject'],
                  style: GoogleFonts.manrope(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${widget.snap['author']}',
                  style: GoogleFonts.manrope(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1.7)),
                  child: Center(
                    child: Text(
                      widget.snap['tags'],
                      style: GoogleFonts.manrope(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  'Semester ${widget.snap['sem']}',
                  style: GoogleFonts.manrope(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: const ButtonStyle(
                    iconSize: MaterialStatePropertyAll(20),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const FaIcon(FontAwesomeIcons.shareNodes),
                onPressed: () {},
              ),
              TextButton(
                style: const ButtonStyle(
                    iconSize: MaterialStatePropertyAll(20),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const FaIcon(FontAwesomeIcons.comment),
                onPressed: () {},
              ),
              TextButton(
                style: const ButtonStyle(
                    iconSize: MaterialStatePropertyAll(20),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const FaIcon(FontAwesomeIcons.download),
                onPressed: () {},
              ),
              TextButton(
                style: const ButtonStyle(
                    iconSize: MaterialStatePropertyAll(20),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const FaIcon(FontAwesomeIcons.listCheck),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: const Text("Open PDF"),
          ),
        ],
      ),
    );
  }
}
