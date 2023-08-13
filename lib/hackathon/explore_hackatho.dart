import 'package:flutter/material.dart';
import 'package:notex/utils/constants.dart';

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
        title: const Text(
          'Explore Hackathons',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Center(
          // for item in data make listTile
          child: Scrollbar(
        child: ListView(
          children: [
            for (var item in data)
              ListTile(
                title: Text(item['name']),
                subtitle: Text(item['link']),
              ),
          ],
        ),
      )),
    );
  }
}
