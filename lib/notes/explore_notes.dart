import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/pdf_box.dart';

class ExploreNotes extends StatefulWidget {
  const ExploreNotes({super.key});

  @override
  State<ExploreNotes> createState() => _ExploreNotesState();
}

class _ExploreNotesState extends State<ExploreNotes> {
  @override
  Widget build(BuildContext context) {
    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56.5),
      child: AppBar(
        title: Container(
          alignment: const Alignment(-0.2, -0.9),
        ),
        toolbarHeight: 56.5,
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("pdf").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none || ConnectionState.waiting:
              return const LinearProgressIndicator(
                color: Color.fromARGB(255, 0, 255, 8),
              );

            default:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: PdfBox(snap: snapshot.data!.docs[index].data()),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
