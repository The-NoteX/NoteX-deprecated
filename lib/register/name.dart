import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/register/semester.dart';
import 'package:notex/utils/next_button.dart';
import '../utils/constants.dart';

class Name extends StatefulWidget {
  const Name({super.key});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  final _textController = TextEditingController();

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
      backgroundColor: backgroundColor,
      body: ListView(
        padding: EdgeInsets.only(
            top: hght * 0.2,
            right: wdth * 0.01,
            left: wdth * 0.01,
            bottom: hght * 0.01),
        children: [
          // app logo

          Center(
            child: Image.asset("assests/logo5.png", scale: hght * 0.0025),
          ),
          const SizedBox(height: 75),

          // name

          Container(
            alignment: const Alignment(-0.7, -1),
            child: Text(
              "Name",
              style: GoogleFonts.manrope(
                fontSize: wdth * 0.1,
                fontWeight: FontWeight.w300,
              ),
              softWrap: true,
            ),
          ),
          const SizedBox(height: 10),

          // name field

          Padding(
            padding: EdgeInsets.only(left: wdth * 0.05, right: wdth * 0.1),
            child: TextFormField(
              controller: _textController,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.justify,
              scrollPhysics: const BouncingScrollPhysics(),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                constraints: const BoxConstraints(
                  minHeight: 70,
                  maxHeight: 100,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                hintText: "Name",
                labelStyle: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 35),

          //next

          NextButton(
            onTap: () {
              if (_textController.text.trim().isEmpty) {
                showSnackBar(context, "Plz enter your name");
              } else {
                username = _textController.text.trim();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Semester()));
              }
            },
          )
        ],
      ),
    );
  }
}
