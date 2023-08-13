import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/profile/update_profile.dart';
import 'package:notex/utils/constants.dart';

import '../home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Credentials? _credentials;

  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-ik8k4e5s5gh2erad.us.auth0.com',
        '6OJfo7nJS8HyJ6heJuDVlGE5xndshuWu');
  }

  @override
  Widget build(BuildContext context) {
    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56.5),
      child: AppBar(
        toolbarHeight: 56.5,
        leading: IconButton(
          iconSize: 24.5,
          icon: const FaIcon(Icons.abc),
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        children: [
          // profile pic

          const Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage("assests/th.jpeg"),
            ),
          ),
          const SizedBox(height: 20),

          // name

          Center(
            child: Text(
              "$username",
              style: GoogleFonts.manrope(
                fontSize: hght * 0.07,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 50),

          // branch

          Center(
            child: Text(
              "Branch:  $branch",
              style: GoogleFonts.manrope(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // sem

          Center(
            child: Text(
              "Semester: $semester",
              style: GoogleFonts.manrope(
                  fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 50),

          // update details

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: InkWell(
              overlayColor: const MaterialStatePropertyAll(
                Color.fromARGB(255, 88, 245, 245),
              ),
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProfile(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.userPen),
                    const SizedBox(width: 15),
                    Text(
                      "Update Details",
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // log out

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              overlayColor: const MaterialStatePropertyAll(
                Color.fromARGB(255, 88, 245, 245),
              ),
              onTap: () async {
                await auth0.webAuthentication().logout(
                    returnTo:
                        "notex://dev-ik8k4e5s5gh2erad.us.auth0.com/android/com.example.notex/callback");
                setState(() {
                  _credentials = null;
                });

                // ignore: use_build_context_synchronously
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.doorOpen),
                    const SizedBox(width: 15),
                    Text(
                      "Log Out",
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
