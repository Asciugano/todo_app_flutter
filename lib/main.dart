import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/classes/list_todo.dart';
import 'package:todo_app_flutter/data/classes/todo_item.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/pages/welcome_page.dart';
import 'package:todo_app_flutter/views/widget_tree.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Europe/Rome'));
  
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

  const iniSetings = InitializationSettings(android: androidInit, iOS: iosInit);
  
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >()
      ?.requestPermissions(alert: true, badge: true, sound: true);
  await flutterLocalNotificationsPlugin.initialize(iniSetings);

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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadThemeColor();
      loadListTodo();
      loadTodo();
    });
  }

  @override
  void dispose() {
    saveListTodo();
    saveTodo();
    super.dispose();
  }

  Future saveTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonTodos =
        todoListNotifier.value
            .map((todo) => jsonEncode(todo.toJson()))
            .toList();
    print(jsonTodos);
    await prefs.setStringList(KKeys.jsonTodos, jsonTodos);
  }
  
  Future saveListTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonListTodo =
        listTodoNotifier.value
            .map((list) => jsonEncode(list.toJson()))
            .toList();
    print(jsonListTodo);
    await prefs.setStringList(KKeys.jsonListTodo, jsonListTodo);
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

  Future loadTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonTodos = prefs.getStringList(KKeys.jsonTodos);
    print(jsonTodos);

    if (jsonTodos != null) {
      todoListNotifier.value =
          jsonTodos.map((json) => TodoItem.fromJson(jsonDecode(json))).toList();
      print(todoListNotifier.value);
    }
  }
  
  Future loadListTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonListTodo = await prefs.getStringList(KKeys.jsonListTodo);
    print(jsonListTodo);

    if(jsonListTodo != null) {
      listTodoNotifier.value = jsonListTodo.map((json) => ListTodo.fromJson(jsonDecode(json))).toList();
      print(listTodoNotifier.value);
    }
  }

  Future<Widget> showWlecome() async {
    final prefs = await SharedPreferences.getInstance();
    final showelcomePage = prefs.getBool(KKeys.showWelcome);
    print(showelcomePage);
    if (showelcomePage != null) {
      return showelcomePage ? WelcomePage() : WidgetTree();
    }
    return WelcomePage();
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
          home: FutureBuilder<Widget>(
            future: showWlecome(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Scaffold(body: Center(child: Text('ERROR')));
              } else {
                return snapshot.data!;
              }
            },
          ),
        );
      },
    );
  }
}