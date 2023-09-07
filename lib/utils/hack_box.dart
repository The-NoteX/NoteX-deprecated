import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HackBox extends StatefulWidget {
  final dynamic snap;

  const HackBox({
    super.key,
    required this.snap,
  });

  @override
  State<HackBox> createState() => _HackBoxState();
}

class _HackBoxState extends State<HackBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 223, 223),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Colors.black,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Image.network(
                    widget.snap['image'],
                    scale: 2.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.snap['date'],
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 175),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.snap['name'],
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Text(
                  widget.snap['location'],
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.snap['mode'],
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
