import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/classes/list_todo.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({super.key, required this.listTodo});

  final ListTodo listTodo;

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('list'),
      onDismissed: (direction) => deleteList(),
      direction: DismissDirection.startToEnd,
      background: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: ListTile(title: Text('Elimina'), trailing: Icon(Icons.delete)),
        ),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    widget.listTodo.title,
                    style: KTextStyle.titleText(themeColorNotifier.value),
                  ),
                  Expanded(child: Container()),
                  Text('id: ${widget.listTodo.id}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deleteList() {
    listTodoNotifier.value.remove(widget.listTodo);
    saveList();
  }

  void saveList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonListTodo =
        todoListNotifier.value
            .map((list) => jsonEncode(list.toJson()))
            .toList();
    await prefs.setStringList(KKeys.jsonListTodo, jsonListTodo);
  }
}