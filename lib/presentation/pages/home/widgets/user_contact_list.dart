import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:ceiba_challenge/presentation/pages/home/widgets/user_card_widget.dart';
import 'package:ceiba_challenge/presentation/resources/values_manager.dart';
import 'package:ceiba_challenge/presentation/widgets/loading_widget.dart';
import 'package:ceiba_challenge/services/user_service.dart';
import 'package:flutter/material.dart';

class UserContactList extends StatelessWidget {
  final UserService userService;

  const UserContactList({Key? key, required this.userService})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (userService.isLoadingUsers) {
      return LoadingWidget();
    }

    List<UserModel> users = (userService.usersFiltered.isEmpty)
        ? userService.users
        : userService.usersFiltered;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSize.s20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCard(user: users[index]);
        },
      ),
    );
  }
}
