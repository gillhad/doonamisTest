import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/config/navigation/navigator_router.dart';
import 'package:sillicon_films/src/config/navigation/navigator_routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: NavigationRoutes.login,
      theme: AppStyles.getAppTheme(context),
    );
  }
}
