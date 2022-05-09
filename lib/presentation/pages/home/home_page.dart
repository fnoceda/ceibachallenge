import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:ceiba_challenge/presentation/pages/home/widgets/appbar_widget.dart';
import 'package:ceiba_challenge/presentation/pages/home/widgets/user_contact_list.dart';
import 'package:ceiba_challenge/presentation/pages/home/widgets/searchinput_widget.dart';
import 'package:ceiba_challenge/presentation/resources/color_manager.dart';
import 'package:ceiba_challenge/presentation/resources/strings_manager.dart';
import 'package:ceiba_challenge/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late UserService userService;
  @override
  Widget build(BuildContext context) {
    userService = Provider.of<UserService>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
        color: ColorManager.statusBarColor,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.09),
              child: MyAppBar(
                title: AppStrings.homeAppBarTitle,
              ),
            ),
            body: Column(
              children: [
                SearchInput(userService: userService),
                Expanded(child: UserContactList(userService: userService)),
              ],
            ),
          ),
        ));
  }
}
