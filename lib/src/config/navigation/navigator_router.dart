import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/navigation/navigator_routes.dart';
import 'package:sillicon_films/src/ui/screens/auth/login.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
        case NavigationRoutes.login :
        return MaterialPageRoute(builder: (context){
        return SignIn();
        });
    }
    return MaterialPageRoute(builder: (context){
      return SignIn();
    });
  }
}