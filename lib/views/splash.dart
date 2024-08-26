import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itunes/config/colors.dart';
import 'package:itunes/config/route_path.dart';
import 'package:itunes/helpers/common_helpers.dart';
import 'package:safe_device/safe_device.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool isJailBroken = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    try {
      isJailBroken = await SafeDevice.isJailBroken;
      if (!isJailBroken) {
        updateScreen();
      }
      setState(() {});
    } catch (error) {
      showLog(error.toString());
    }
  }

  updateScreen() async {
    Timer(const Duration(seconds: 1), () {
      context.pushReplacementNamed(RoutePath.search.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 100),
        child: isJailBroken
            ? Text(
                "JailBroken/Rooted Device Not Supported",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              )
            : Image.asset(
                "assets/images/logo.png",
                width: screenSize.width * 0.3,
                color: ITunesColors.whiteColor,
              ),
      ),
    );
  }
}
