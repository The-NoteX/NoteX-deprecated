import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:notex/home.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
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
    return Scaffold(
      body: ElevatedButton(
        onPressed: () async {
          await auth0.webAuthentication().logout(returnTo:"notex://dev-ik8k4e5s5gh2erad.us.auth0.com/android/com.example.notex/callback");
          setState(() {
            _credentials = null;
          });

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: const Center(
          child: Text('Logout'),
        ),
      ),
    );
  }
}
