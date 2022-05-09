import 'package:ceiba_challenge/domain/models/post_model.dart';
import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:ceiba_challenge/presentation/pages/home/widgets/appbar_widget.dart';
import 'package:ceiba_challenge/presentation/pages/home/widgets/user_card_widget.dart';
import 'package:ceiba_challenge/presentation/resources/color_manager.dart';
import 'package:ceiba_challenge/presentation/resources/strings_manager.dart';
import 'package:ceiba_challenge/presentation/resources/styles_manager.dart';
import 'package:ceiba_challenge/presentation/widgets/loading_widget.dart';
import 'package:ceiba_challenge/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsView extends StatelessWidget {
  final UserModel user;
  PostsView({Key? key, required this.user}) : super(key: key);
  late BuildContext _myContext;
  @override
  Widget build(BuildContext context) {
    UserService userService = Provider.of<UserService>(context, listen: false);
    _myContext = context;
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
                UserCard(user: user, showButton: false),
                Expanded(child: _postsListWidget(user.id!, userService)),
              ],
            ),
          ),
        ));
  }

  _postsListWidget(int userId, UserService userService) {
    return FutureBuilder(
        future: userService.getPosts(userId: userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            List<PostModel> posts = snapshot.data as List<PostModel>;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return _postCard(posts[index]);
                });
          }
          return Container();
        });
  }

  Widget _postCard(PostModel post) {
    return Card(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            post.title,
            style: getTextButtonStyle(color: ColorManager.primary),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: Text(
            post.body,
            style: getRegularStyle(color: ColorManager.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}
