import 'package:flutter/material.dart';

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
        title: const Text('API Data Display'),
      ),
      body: Center(
        child: data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index]['title']),
                    subtitle: Text(data[index]['description']),
                  );
                },
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
