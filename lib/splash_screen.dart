import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // init();
    super.didChangeDependencies();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isLoggedIn =
        prefs.getString(Constant.kSetPrefToken)?.isNotEmpty ?? false;

    Timer(
      Duration(seconds: 1),
      () => Navigator.pushNamedAndRemoveUntil(
          context, isLoggedIn ? '/home' : '/login', (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(Assets.imagesImgLogoSigap),
            )
          ],
        ),
      ),
    );
  }
}
