import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    loadThemeColor();
    super.initState();
  }

  Future loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final int? intColor = prefs.getInt(KKeys.themeColorKey);

    if (intColor != null) {
      themeColorNotifier.value = Color(intColor);
    } else {
      themeColorNotifier.value = Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeColorNotifier,
      builder: (context, themeColor, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeColor,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeColor,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: ThemeMode.system,
          home: WelcomePage(),
        );
      },
    );
  }
}