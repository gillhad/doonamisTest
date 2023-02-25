import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/navigation/navigator_routes.dart';
import 'package:sillicon_films/src/ui/screens/auth/login.dart';
import 'package:sillicon_films/src/ui/screens/home/home.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
        case NavigationRoutes.login :
        return MaterialPageRoute(builder: (context){
        return SignIn();
        });
        case NavigationRoutes.home :
        return MaterialPageRoute(builder: (context){
        return Home();
        });
    }

    return MaterialPageRoute(builder: (context){
      return SignIn();
    });
  }
}