import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/classes/todo_item.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/pages/creation_page.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({super.key, required this.item});

  final TodoItem item;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('item'),
      onDismissed: (direction) => deleteItem(),
      direction: DismissDirection.startToEnd,
      background: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: ListTile(title: Text('Elimina'), leading: Icon(Icons.delete)),
        ),
      ),
      child: GestureDetector(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreationPage(item: widget.item),
              ),
            ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Checkbox(
                    tristate: false,
                    value: widget.item.isCompleted,
                    onChanged:
                        (bool? value) => setState(() {
                          widget.item.isCompleted = value!;
                        }),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.item.title,
                        style: KTextStyle.titleText(
                          themeColorNotifier.value,
                          isCompleted: widget.item.isCompleted,
                        ),
                      ),
                      Text(
                        widget.item.desctiption,
                        style: KTextStyle.descriptionText(
                          isCompleted: widget.item.isCompleted,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  if (widget.item.scadenza != null)
                    Text(
                      '${widget.item.scadenza!.day}/${widget.item.scadenza!.month}/${widget.item.scadenza!.year}',
                      style: KTextStyle.descriptionText(
                        isCompleted: widget.item.isCompleted,
                      ),
                    ),
                  SizedBox(width: 10),
                  Text(
                    widget.item.priorityLevel.label,
                    style: KTextStyle.descriptionText(
                      isCompleted: widget.item.isCompleted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deleteItem() {
    todoListNotifier.value.remove(widget.item);
    saveTodo();
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
}