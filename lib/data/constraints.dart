import 'package:flutter/widgets.dart';

class KPage {
  static const int homePageIndex = 0;
  static const int todoPageIndex = 1;
  static const int profilePageIndex = 2;
}

class KKeys {
  static const String themeColorKey = 'themeColorKey';
  static const String jsonTodos = 'jsonTodos';
  static const String showWelcome = 'showWelcome';
  static const String listTodoCurrentId = 'listTodoCurrentId';
  static const String jsonListTodo = 'jsonListTodo';
}

class KTextStyle {
  static TextStyle titleText(Color color, {bool isCompleted = false}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        decoration: isCompleted ? TextDecoration.lineThrough : null,
      );
      
  static TextStyle descriptionText({bool isCompleted = false}) => TextStyle(
    fontSize: 16,
    decoration: isCompleted ? TextDecoration.lineThrough : null,
  );
}