import 'package:ceiba_challenge/presentation/resources/color_manager.dart';
import 'package:ceiba_challenge/presentation/resources/styles_manager.dart';
import 'package:ceiba_challenge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return AppBar(
      title: Text(
        title,
        style: getTitleStyle(color: ColorManager.primaryBackgroudColor),
      ),
      centerTitle: false,
      backgroundColor: ColorManager.primary,
      elevation: AppSize.s0,
    );
  }
}
