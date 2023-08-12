import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Name extends StatefulWidget {
  const Name({super.key});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
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
    return const Scaffold();
  }
}
