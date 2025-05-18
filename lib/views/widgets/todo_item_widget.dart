import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/classes/todo_item.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/main.dart';
import 'package:todo_app_flutter/views/pages/creation_page.dart';
import 'package:timezone/timezone.dart' as tz;

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
                          cancelTodoNotification(widget.item);
                        }),
                  ),
                  Expanded(
                    child: Column(
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
                  ),
                  Expanded(child: Container()),
                  Column(
                    children: [
                      if (widget.item.scadenza != null)
                        Text(
                          '${widget.item.scadenza!.day}/${widget.item.scadenza!.month}/${widget.item.scadenza!.year}',
                          style: KTextStyle.descriptionText(
                            isCompleted: widget.item.isCompleted,
                          ),
                        ),
                      SizedBox(height: 10),
                      Text(
                        widget.item.priorityLevel.label,
                        style: KTextStyle.descriptionText(
                          isCompleted: widget.item.isCompleted,
                        ),
                      ),
                    ],
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

  Future cancelTodoNotification(TodoItem item) async {
    if (item.isCompleted) {
      await flutterLocalNotificationsPlugin.cancel(
        item.title.hashCode ^ item.scadenza.hashCode,
      );
      await flutterLocalNotificationsPlugin.cancel(
        item.title.hashCode ^ item.scadenza.hashCode ^ 1,
      );
    } else {
      scheduleTodoNotification(item);
      scheduleTodoNotification(item, giorniInMeno: 1);
    }
  }

  Future scheduleTodoNotification(TodoItem item, {int giorniInMeno = 0}) async {
    if (item.scadenza != null) {
      if (item.scadenza!.isBefore(DateTime.now())) {
        return;
      }
      await flutterLocalNotificationsPlugin.zonedSchedule(
        item.title.hashCode ^ item.scadenza.hashCode ^ giorniInMeno,
        'In scadenza: ${item.title}',
        '${item.title} sta per scadere(${item.scadenza})',
        tz.TZDateTime.from(
          item.scadenza!.subtract(Duration(days: giorniInMeno)),
          tz.local,
        ),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'todo_channe',
            'Notifiche todo',
            channelDescription: 'Notifiche per la scadenza dei Todo',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }
}
