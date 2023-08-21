import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HackBox extends StatefulWidget {
  final dynamic name;
  final dynamic link;
  final dynamic image;
  final dynamic date;
  final dynamic location;
  final dynamic mode;
  const HackBox({
    super.key,
    required this.name,
    required this.link,
    required this.image,
    required this.date,
    required this.location,
    required this.mode,
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
                    widget.image,
                    scale: 2.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.date,
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
                  widget.name,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Text(
                  widget.location,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.mode,
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
