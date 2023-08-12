import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class NextButton extends StatelessWidget {
  final Function()? onTap;
  const NextButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wdth * 0.23),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
        ),
        constraints: BoxConstraints(
          maxHeight: hght * 0.09,
        ),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              "Next",
              style: GoogleFonts.manrope(
                fontSize: hght * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
