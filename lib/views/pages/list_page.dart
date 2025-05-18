import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: listTodoNotifier,
          builder: (context, listTodo, child) {
            return Column(
              children: List.generate(
                listTodoNotifier.value.length,
                (i) => TodoListWidget(listTodo: listTodoNotifier.value[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}