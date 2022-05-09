import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:ceiba_challenge/presentation/resources/assets_manager.dart';
import 'package:ceiba_challenge/presentation/resources/color_manager.dart';
import 'package:ceiba_challenge/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryBackgroudColor,
      body: Center(
        child: FadeIn(
          duration: Duration(seconds: 1),
          child: Image(
            image: AssetImage(ImageAssets.splashLogo),
          ),
        ),
      ),
    );
  }
}
