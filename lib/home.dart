import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Column(
        children: [
          // app logo

          Center(child: Image.asset("assests/logo5.png", scale: 2)),
          const SizedBox(height: 30),

          // App Name

          Center(
            child: Text(
              "NoteX",
              style: GoogleFonts.manrope(
                fontSize: 50,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // text

          Center(
            child: Text(
              "Share notes, connect with people, crack ",
              style: GoogleFonts.manrope(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
          ),

          Center(
            child: Text(
              "university examinations",
              style: GoogleFonts.manrope(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
          ),
          const SizedBox(height: 40),

          // next button

          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            constraints: BoxConstraints(
              maxWidth: wdth * 0.4,
              maxHeight: hght * 0.05,
            ),
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text(
                  "Shall We",
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
