import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/arguments.dart';
import 'package:sillicon_films/src/config/navigation/navigator_routes.dart';
import 'package:sillicon_films/src/ui/screens/auth/login.dart';
import 'package:sillicon_films/src/ui/screens/home/home.dart';
import 'package:sillicon_films/src/ui/screens/home/item_detail.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
        case NavigationRoutes.login :
        return MaterialPageRoute(builder: (context){
        return const SignIn();
        });
        case NavigationRoutes.home :
        return MaterialPageRoute(builder: (context){
        return Home();
        });
      case NavigationRoutes.detail :
        DetailArguments _arguments = settings.arguments as DetailArguments;
        return MaterialPageRoute(builder: (context){
          return ItemDetail(
            itemInfo: _arguments.serie,
          );
        });
    }
    return MaterialPageRoute(builder: (context){
      return SignIn();
    });
  }
}