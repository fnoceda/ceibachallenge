import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:ceiba_challenge/presentation/resources/color_manager.dart';
import 'package:ceiba_challenge/presentation/resources/font_manager.dart';
import 'package:ceiba_challenge/presentation/resources/strings_manager.dart';
import 'package:ceiba_challenge/presentation/resources/styles_manager.dart';
import 'package:ceiba_challenge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final bool showButton;
  const UserCard({Key? key, required this.user, this.showButton = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 180,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(AppSize.s20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? '',
                style: getTitleStyle(color: ColorManager.primary),
              ),
              SizedBox(height: AppSize.s4),
              _myTileRow(user.phone ?? '', Icons.phone),
              SizedBox(height: AppSize.s4),
              _myTileRow(user.email ?? '', Icons.email),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    color: Colors.red,
                  ),
                  if (showButton)
                    TextButton(
                      child: Text(
                        AppStrings.showPubText,
                        style: getTextButtonStyle(color: ColorManager.primary),
                      ),
                      onPressed: () async {
                        Navigator.pushNamed(
                          context,
                          '/posts',
                          arguments: user,
                        );
                      },
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _myTileRow(String texto, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: ColorManager.primary),
        SizedBox(width: AppSize.s4),
        Text(
          texto,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s18),
        ),
      ],
    );
  }
}
