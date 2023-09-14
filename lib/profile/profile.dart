import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/profile/update_profile.dart';
import 'package:notex/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _credentials = false;
  late Auth0 _auth0;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    _auth0 = Auth0('dev-ik8k4e5s5gh2erad.us.auth0.com',
        '6OJfo7nJS8HyJ6heJuDVlGE5xndshuWu');
  }

  getUserDetails() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _credentials = true;
    });
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("logged in", false);

    await _auth0.webAuthentication().logout(
        returnTo:
            "notex://dev-ik8k4e5s5gh2erad.us.auth0.com/android/com.example.notex/callback");

    // ignore: use_build_context_synchronously
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_credentials
        ? const Align(
            alignment: Alignment(-1, -0.8),
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Colors.cyan,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 223, 223, 223),
              forceMaterialTransparency: true,
              toolbarHeight: 70,
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              children: [
                // profile pic

                const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 123,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: AssetImage("assests/th.jpeg"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // name

                Center(
                  child: Text(
                    _prefs.getString('username')!,
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
                    "Branch:  ${_prefs.getString('branch')}",
                    style: GoogleFonts.manrope(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // sem

                Center(
                  child: Text(
                    "Semester: ${_prefs.getInt('semester')}",
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
                      Navigator.pushReplacement(
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
                    onTap: logOut,
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
