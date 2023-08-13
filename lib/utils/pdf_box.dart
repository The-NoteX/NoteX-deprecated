import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 223, 223),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.snap['subject'],
            style: GoogleFonts.manrope(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '-${widget.snap['author']}',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: backgroundColor,
                  border: Border.all(
                    width: 1.5,
                  ),
                ),
                child: Center(
                    child: Text(
                  widget.snap['tags'],
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ),
              const SizedBox(height: 10),
              TextButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(StadiumBorder()),
                  fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
                ),
                onPressed: () {
                  print("4");
                },
                child: Container(
                  alignment: const Alignment(-0.9, 0),
                  child: const Text("Open PDF"),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  //   alignment: const Alignment(0.8, 0),
                  child: Text(widget.snap['sem'])),
            ],
          ),
        ],
      ),
    );
  }
}
