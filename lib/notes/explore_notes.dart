import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/pdf_box.dart';

class ExploreNotes extends StatefulWidget {
  const ExploreNotes({super.key});

  @override
  State<ExploreNotes> createState() => _ExploreNotesState();
}

class _ExploreNotesState extends State<ExploreNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(
            top: 3.0,
            left: 10,
          ),
          child: Text(
            'Explore Notes',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        forceMaterialTransparency: true,
        toolbarHeight: 70,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("pdf")
            .orderBy('likes', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none || ConnectionState.waiting:
              return const LinearProgressIndicator(
                color: Color.fromARGB(255, 0, 255, 8),
              );

            default:
              // return ListView.builder(
              //   itemCount: snapshot.data!.docs.length,
              //   itemBuilder: (context, index) {
              //     return SafeArea(
              //       minimum: const EdgeInsets.symmetric(
              //           horizontal: 10, vertical: 2.5),
              //       child: PdfBox(snap: snapshot.data!.docs[index].data()),
              //     );
              //   },
              // );
              return ListWheelScrollView.useDelegate(
                physics: const BouncingScrollPhysics(),
                itemExtent: 275,
                // squeeze: 2,
                diameterRatio: 8,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: snapshot.data!.docs.length,
                  builder: (context, index) {
                    return PdfBox(snap: snapshot.data!.docs[index].data());
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
