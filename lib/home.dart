import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _confettiController = ConfettiController();

  @override
  void dispose() {
    super.dispose();
    _confettiController.dispose();
  }

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

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: ListView(
            padding: EdgeInsets.only(
              top: hght * 0.2,
              right: wdth * 0.01,
              left: wdth * 0.01,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              // app logo

              Slidable(
                startActionPane: ActionPane(
                  extentRatio: 1,
                  motion: const BehindMotion(),
                  children: [
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            print("wo");
                            _confettiController.play();

                            showSnackBar(
                                context, "You discovered the Easter Egg");

                            Future.delayed(
                              const Duration(seconds: 4),
                              () {
                                _confettiController.stop();
                              },
                            );
                          },
                          child: Image.asset("assests/mascot-blush.png")),
                    ),
                  ],
                ),
                child:
                    Center(child: Image.asset("assests/logo5.png", scale: 2)),
              ),
              const SizedBox(height: 30),

              // App Name

              Center(
                child: Text(
                  "NoteX",
                  style: GoogleFonts.manrope(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // text

              Center(
                child: Text(
                  "Share notes, connect with people, crack ",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: true,
                ),
              ),

              Center(
                child: Text(
                  "university examinations",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 50),

              // next button

              Padding(
                padding: EdgeInsets.symmetric(horizontal: wdth * 0.2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: hght * 0.09,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        "Shall We ?",
                        style: GoogleFonts.manrope(
                          fontSize: 27,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ConfettiWidget(
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: _confettiController,
          blastDirection: pi / 2,
          gravity: hght * hght * 0.0000002,
          emissionFrequency: 0.075,
          maxBlastForce: 10,
          minBlastForce: 9,
        ),
      ],
    );
  }
}
