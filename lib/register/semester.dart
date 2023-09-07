import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/register/branch.dart';
import 'package:notex/utils/next_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class Semester extends StatefulWidget {
  const Semester({super.key});

  @override
  State<Semester> createState() => _SemesterState();
}

int _sem = 0;

class _SemesterState extends State<Semester> {
  void onButtonPressed(int index) {
    setState(() {
      _sem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // appbar

    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56.5),
      child: AppBar(
        toolbarHeight: 56.5,
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
      ),
    );

    // buttons list

    List<String> buttonsText = [
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
    ];

    List<Widget> buttons = List.generate(
      buttonsText.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: ElevatedButton(
            onPressed: () {
              onButtonPressed(index + 1);
            },
            style: ElevatedButton.styleFrom(
              shape:
                  const StarBorder.polygon(sides: 4, squash: 1, rotation: 100),
              foregroundColor: _sem == index + 1 ? Colors.white : Colors.black,
              backgroundColor: _sem == index + 1 ? Colors.black : Colors.white,
            ),
            child: Text(
              buttonsText[index],
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w600,
                fontSize: _sem == index + 1 ? 20 : 13,
              ),
            ),
          ),
        );
      },
      growable: true,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: ListView(
        padding: EdgeInsets.only(
          top: hght * 0.2,
          right: wdth * 0.01,
          left: wdth * 0.01,
          bottom: hght * 0.01,
        ),
        children: [
          // app logo

          Center(
            child: Image.asset("assests/logo5.png", scale: hght * 0.0025),
          ),
          const SizedBox(height: 75),

          // semester

          Container(
            alignment: const Alignment(-0.7, -1),
            child: Text(
              "Semester",
              style: GoogleFonts.manrope(
                fontSize: wdth * 0.1,
                fontWeight: FontWeight.w300,
              ),
              softWrap: true,
            ),
          ),
          const SizedBox(height: 10),

          // sem button

          Center(child: Wrap(children: buttons)),
          const SizedBox(height: 30),

          // next

          NextButton(
            onTap: () async {
              if (_sem == 0) {
                showSnackBar(context, "Plz select a semester");
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt("semester", _sem);
                prefs.getInt('semester');

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Branch()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
