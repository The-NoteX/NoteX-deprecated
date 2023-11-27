import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../utils/constants.dart';
import '../utils/pdf_box.dart';

class ExploreNotes extends StatefulWidget {
  const ExploreNotes({super.key});

  @override
  State<ExploreNotes> createState() => _ExploreNotesState();
}

class _ExploreNotesState extends State<ExploreNotes> {
  String _subject = "";

  @override
  Widget build(BuildContext context) {
    Object orderBy = _subject == "" ? 'likes' : 'subject';

    var newStream = FirebaseFirestore.instance
        .collection("pdf")
        .orderBy(
          orderBy,
          descending: true,
        )
        .where(orderBy, isEqualTo: _subject)
        .snapshots();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _subject = "";
          });
        },
        child: Icon(MdiIcons.delete),
      ),
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
        flexibleSpace: SafeArea(
          child: Align(
            alignment: const Alignment(0.75, 0),
            child: DropdownButton(
              items: subjects.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              underline: Container(color: Colors.transparent),
              iconSize: 50,
              iconEnabledColor: Colors.black,
              icon: Icon(MdiIcons.menuDown),
              dropdownColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _subject = value!;
                });
              },
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        forceMaterialTransparency: true,
      ),
      body: StreamBuilder(
        stream: orderBy == 'likes'
            ? FirebaseFirestore.instance
                .collection("pdf")
                .orderBy(
                  orderBy,
                  descending: true,
                )
                .snapshots()
            : newStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none || ConnectionState.waiting:
              return const LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.cyan,
              );

            default:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                cacheExtent: snapshot.data!.docs.length.toDouble(),
                itemBuilder: (context, index) {
                  return PdfBox(snap: snapshot.data!.docs[index].data());
                },
              );
          }
        },
      ),
    );
  }
}
