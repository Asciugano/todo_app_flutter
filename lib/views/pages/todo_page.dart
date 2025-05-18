import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/widgets/todo_item_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  final int? listID = currentListIDNotifier.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: todoListNotifier,
        builder: (context, todoList, child) {
          final filteredList =
              listID != null
                  ? todoList
                      .where((todo) => todo.listID == listID)
                      .toList()
                  : todoList;

          return Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: AnimatedCrossFade(
                firstChild: Column(
                  children: List.generate(
                    filteredList.length,
                    (i) => TodoItemWidget(item: filteredList[i]),
                  ),
                ),
                secondChild: Column(
                  children: [
                    Image.asset('assets/img/paperella_spaesata.png'),
                    Text('Non c\'é nulla da fare'),
                  ],
                ),
                crossFadeState:
                    filteredList.isEmpty
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
            ),
          );
        },
      ),
    );
  }
}