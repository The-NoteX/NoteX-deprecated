import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/utils/constants.dart';

class Comments extends StatefulWidget {
  final snap;
  const Comments({super.key, required this.snap});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56.5),
      child: AppBar(
        title: Container(
          alignment: const Alignment(-0.25, -0.9),
          child: Text(
            "Upload Notes",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        toolbarHeight: 56.5,
        leading: IconButton(
          iconSize: 24.5,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: appBar,
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('pdf')
      //       .doc(widget.snap)
      //       .collection('comments')
      //       .snapshots(),
      //   builder: (BuildContext context,
      //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {},
      // ),
    );
  }
}
