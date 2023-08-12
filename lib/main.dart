import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:notex/navigation.dart';
import 'package:notex/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeDilation = 1;
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    hght = MediaQuery.of(context).size.height;
    wdth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );

    return const MaterialApp(
      home: Navigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
