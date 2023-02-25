import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/app.dart';
import 'package:sillicon_films/src/providers/info_provider.dart';

final mainProvider = Provider((_)=> InfoProvider());

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
      ProviderScope(
      child: MyApp()
      )
  );
}

