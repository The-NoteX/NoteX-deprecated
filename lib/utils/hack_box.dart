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
        ),
      ),
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
                  child: ImageWidget(snap: widget.snap),
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
            constraints: const BoxConstraints(maxWidth: 165),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    widget.snap['name'],
                    softWrap: false,
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.snap['location'],
                    softWrap: false,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.snap['mode'],
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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

class ImageWidget extends StatefulWidget {
  final dynamic snap;
  const ImageWidget({super.key, required this.snap});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.snap['image'],
      scale: 2.5,
      loadingBuilder: (context, child, progress) {
        return progress == null
            ? child
            : Center(
                child: CircularProgressIndicator(
                  value: progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!,
                  backgroundColor: Colors.transparent,
                  color: Colors.cyan,
                ),
              );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Stack(
          children: [
            Placeholder(
              fallbackHeight: 100,
              fallbackWidth: 100,
            )
          ],
        );
      },
    );
  }
}
