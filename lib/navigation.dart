import 'package:flutter/material.dart';

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
        height: 60,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.black,
        selectedIndex: _page,
        onDestinationSelected: (value) {
          setState(() {
            _page = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(size: 30, Icons.home_outlined, color: Colors.white),
            selectedIcon: Icon(size: 30, Icons.home, color: Colors.white),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
                size: 30, Icons.lightbulb_outline_rounded, color: Colors.white),
            selectedIcon: Icon(size: 30, Icons.lightbulb, color: Colors.white),
            label: "Hackathons",
          ),

          NavigationDestination(
            icon: Icon(
                size: 30, Icons.add_road_outlined, color: Colors.white),
            selectedIcon: Icon(size: 30, Icons.add_road_outlined, color: Colors.white),
            label: "Internships",
          ),
          NavigationDestination(
            icon: Icon(size: 30, Icons.note_alt_outlined, color: Colors.white),
            selectedIcon: Icon(size: 30, Icons.note_alt, color: Colors.white),
            label: "Upload",
          ),
          NavigationDestination(
            icon: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage("assests/th.jpeg"),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
