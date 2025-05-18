import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/classes/list_todo.dart';
import 'package:todo_app_flutter/data/classes/todo_item.dart';

ValueNotifier<int> currentPageNotifier = ValueNotifier(0);
ValueNotifier<List<TodoItem>> todoListNotifier = ValueNotifier([]);
ValueNotifier<List<ListTodo>> listTodoNotifier = ValueNotifier([]);
ValueNotifier<Color> themeColorNotifier = ValueNotifier(Colors.transparent);