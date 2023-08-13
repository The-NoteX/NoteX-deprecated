import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'utils/constants.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        // height: 60,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.black,
        selectedIndex: _page,
        onDestinationSelected: (value) {
          setState(() {
            _page = value;
          });
        },
        destinations:  [
          NavigationDestination(
            icon: Icon(size: 30, MdiIcons.homeVariantOutline, color: Colors.white),
            selectedIcon: Icon(size: 30, MdiIcons.homeVariant, color: Colors.white),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
                size: 30, MdiIcons.starBox, color: Colors.white),
            selectedIcon: Icon(size: 30, MdiIcons.stackOverflow, color: Colors.white),
            label: "Internships",
          ),
          NavigationDestination(
            icon: Icon(
                size: 30, MdiIcons.lightbulbOnOutline, color: Colors.white),
            selectedIcon: Icon(size: 30, MdiIcons.lightbulbOn, color: Colors.white),
            label: "Hackathons",
          ),

          NavigationDestination(
            icon: Icon(size: 30, MdiIcons.noteEditOutline, color: Colors.white),
            selectedIcon: Icon(size: 30, MdiIcons.note, color: Colors.white),
            label: "Upload",
          ),
          NavigationDestination(
            icon: Icon(size: 30, MdiIcons.faceManProfile, color: Colors.white,),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
