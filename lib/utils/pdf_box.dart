import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:android_x_storage/android_x_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:notex/notes/comment.dart';
import 'package:notex/notes/notes_storage.dart';
import 'package:notex/utils/constants.dart';
import 'package:notex/utils/pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class PdfBox extends StatefulWidget {
  final dynamic snap;
  const PdfBox({
    super.key,
    required this.snap,
  });

  @override
  State<PdfBox> createState() => _PdfBoxState();
}

class _PdfBoxState extends State<PdfBox> {
  bool _liked = false;

  Future<String> downloadPdf() async {
    Navigator.pop(context);
    showSnackBar(context, "Starting Download");

    try {
      final dir = await AndroidXStorage().getDownloadsDirectory();
      var fileName = widget.snap['subject'] + "  " + widget.snap['author'];
      await FlutterDownloader.enqueue(
        fileName: fileName,
        url: widget.snap['pdfurl'],
        savedDir: dir!,
      );
      return "downloaded";
    } catch (e) {
      // ignore: use_build_context_synchronously
      return showSnackBar(context, e.toString());
    }
  }

  Future share() async {
    var response = await http.get(Uri.parse(widget.snap['pdfurl']));
    var bytes = response.bodyBytes;
    var fileName = widget.snap['subject'] + "  " + widget.snap['author'];
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.absolute.path;
    var filePath = '$tempPath/$fileName.pdf';
    await File(filePath).writeAsBytes(bytes);
    final files = <XFile>[];
    files.add(XFile(filePath));
    Share.shareXFiles(files);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 25, 5),
          decoration: BoxDecoration(
            border: Border.all(width: 0),
            color: const Color.fromARGB(255, 246, 246, 246),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
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
              const SizedBox(height: 1),

              // author

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "~${widget.snap['author']}",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  // tag

                  Container(
                    alignment: Alignment.centerLeft,
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border.all(width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Center(
                      child: Text(
                        widget.snap['tags'],
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // semester
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border.all(width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Center(
                      child: Text(
                        'SEM: ${widget.snap['semester']}',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfView(
                              url: widget.snap['pdfurl'],
                              snap: widget.snap,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.solidEye)),
                  IconButton(
                    onPressed: share,
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
                    onPressed: () async {
                      bool status = await Permission.storage.isDenied;

                      if (status) {
                        await Permission.storage.request();
                        bool granted =
                            await Permission.storage.request().isGranted;

                        if (granted) {
                          // ignore: use_build_context_synchronously
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return const Align(
                                alignment: Alignment(0, -0.75),
                                child: SizedBox(
                                  height: 5,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    color: Colors.cyan,
                                  ),
                                ),
                              );
                            },
                          );

                          await downloadPdf();
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return const Align(
                              alignment: Alignment(0, -0.75),
                              child: SizedBox(
                                height: 5,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  color: Colors.cyan,
                                ),
                              ),
                            );
                          },
                        );

                        await downloadPdf();
                      }
                    },
                    icon: const Icon(FontAwesomeIcons.download),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _liked = !_liked;
                          });
                          likePost(
                            widget.snap['docid'],
                            _liked,
                            widget.snap['likes'],
                          );
                        },
                        icon: _liked
                            ? const Icon(FontAwesomeIcons.solidThumbsUp)
                            : const Icon(FontAwesomeIcons.thumbsUp),
                      ),
                      Text(widget.snap['likes'].toString())
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
