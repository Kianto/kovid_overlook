import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kovidoverlook/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return Timer(const Duration(seconds: 2), changeScreen);
  }

  changeScreen() async {
    Navigator.pushReplacementNamed(context, '/home');
//    Navigator.of(context).push(
//      MaterialPageRoute(
//        builder: (BuildContext context){
//          return HomeScreen();
//        },
//      ),
//    );
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image.asset(Constants.iKovidOverlookBanner),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Text(
              "${Constants.appName} by Kianto",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
