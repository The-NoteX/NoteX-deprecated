import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 223, 223),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Text(
            widget.snap['subject'],
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [Text(widget.snap[''])],
          ),
        ],
      ),
    );
  }
}
