import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/widgets/todo_item_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: todoListNotifier,
        builder: (context, todoList, child) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: AnimatedCrossFade(
                firstChild: Column(
                  children: List.generate(
                    todoList.length,
                    (i) => TodoItemWidget(item: todoList[i]),
                  ),
                ),
                secondChild: Column(
                  children: [
                    Image.asset('assets/img/paperella_spaesata.png'),
                    Text('Non c\'é nulla da fare'),
                  ],
                ),
                crossFadeState:
                    todoList.isEmpty
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