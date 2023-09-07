import 'package:android_x_storage/android_x_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'constants.dart';

class PdfView extends StatefulWidget {
  final String url;
  final dynamic snap;
  const PdfView({super.key, required this.url, required this.snap});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  Future<String> downloadPdf() async {
    Navigator.pop(context);
    showSnackBar(context, "Starting Download");

    try {
      final dir = await AndroidXStorage().getDownloadsDirectory();
      var flneName = widget.snap['subject'] + widget.snap['author'];
      await FlutterDownloader.enqueue(
        fileName: flneName,
        url: widget.snap['pdfurl'],
        savedDir: dir!,
      );
      return "downloaded";
    } catch (e) {
      return showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () async {
                bool status = await Permission.storage.isDenied;

                if (status) {
                  await Permission.storage.request();
                  bool granted = await Permission.storage.request().isGranted;

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
                        alignment: Alignment(0, -0.9),
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
              icon: const Icon(
                FontAwesomeIcons.download,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Share.share(widget.snap['pdfurl']);
              },
              icon: Icon(
                MdiIcons.send,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: const PDF(
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        nightMode: false,
        fitPolicy: FitPolicy.WIDTH,
      ).cachedFromUrl(
        widget.url,
        maxNrOfCacheObjects: 10,
        maxAgeCacheObject: const Duration(days: 7),
        placeholder: (progress) => Align(
          alignment: Alignment.topCenter,
          child: LinearProgressIndicator(
            value: progress / 100,
            color: Colors.cyan,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
