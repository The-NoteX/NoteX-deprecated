import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/navigation.dart';
import 'package:notex/utils/constants.dart';
import 'package:notex/utils/next_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Branch extends StatefulWidget {
  const Branch({super.key});

  @override
  State<Branch> createState() => _BranchState();
}

String _branch = "";

class _BranchState extends State<Branch> {
  void onButtonPressed(String index) {
    setState(() {
      _branch = index;
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

    List<String> buttonsText = ["CSE", "ECE"];

    // buttons

    List<Widget> buttons = List.generate(
      buttonsText.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: ElevatedButton(
            onPressed: () {
              onButtonPressed(buttonsText[index]);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 50),
              shape: const StadiumBorder(),
              foregroundColor:
                  _branch == buttonsText[index] ? Colors.white : Colors.black,
              backgroundColor:
                  _branch == buttonsText[index] ? Colors.black : Colors.white,
            ),
            child: Text(
              buttonsText[index],
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w400,
                fontSize: _branch == buttonsText[index] ? 20 : 15,
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
            bottom: hght * 0.01),
        children: [
          // logo

          Center(
            child: Image.asset("assests/logo5.png", scale: hght * 0.0025),
          ),
          const SizedBox(height: 75),

          // branch

          Center(
            child: Text(
              "Branch",
              style: GoogleFonts.manrope(
                fontSize: wdth * 0.1,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
          const SizedBox(height: 20),

          // branch

          Center(child: Wrap(spacing: wdth * 0.07, children: buttons)),
          const SizedBox(height: 50),

          // next

          NextButton(
            onTap: () async {
              if (_branch.isEmpty) {
                showSnackBar(context, "plz choose a branch");
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("branch", _branch);

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Navigation()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
