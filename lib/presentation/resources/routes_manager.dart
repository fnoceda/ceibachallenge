import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:ceiba_challenge/presentation/pages/home/home_page.dart';
import 'package:ceiba_challenge/presentation/pages/posts/posts_page.dart';
import 'package:ceiba_challenge/presentation/pages/splash/splash_page.dart';
import 'package:ceiba_challenge/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String postsRoute = "/posts";

  // static const String loginRoute = "/login";
  // static const String registerRoute = "/register";
  // static const String forgotPasswordRoute = "/forgotPassword";
  // static const String mainRoute = "/main";
  // static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());

      case Routes.postsRoute:
        final args = routeSettings.arguments as UserModel;
        print(args.id);
        return MaterialPageRoute(builder: (_) => PostsView(user: args));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound),
              ),
              body: Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
