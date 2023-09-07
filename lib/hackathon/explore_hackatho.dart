import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/hack_box.dart';
import 'api_hackathon.dart';

class ExploreHackathons extends StatefulWidget {
  const ExploreHackathons({super.key});

  @override
  State<ExploreHackathons> createState() => _ExploreHackathonsState();
}

class _ExploreHackathonsState extends State<ExploreHackathons> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((result) {
      setState(() {
        data = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Explore Hackathons',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        forceMaterialTransparency: true,
        toolbarHeight: 70,
      ),
      body: Center(
          // for item in data make listTile
          child: Scrollbar(
        child: ListView(
          children: [
            for (var item in data)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(item['link']);
                    await launchUrl(url);
                  },
                  child: HackBox(snap: item),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
