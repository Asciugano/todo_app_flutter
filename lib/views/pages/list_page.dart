import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/constraints.dart';
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
      body: ValueListenableBuilder(
        valueListenable: listTodoNotifier,
        builder: (context, listTodo, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: AnimatedCrossFade(
                firstChild: Column(
                  children: List.generate(
                    listTodoNotifier.value.length,
                    (i) => TodoListWidget(listTodo: listTodoNotifier.value[i]),
                  ),
                ),
                secondChild: Column(
                  children: [
                    Image.asset('assets/img/paperella_spaesata.png'),
                    Text(
                      'Non ci sono liste',
                      style: KTextStyle.titleText(themeColorNotifier.value),
                    ),
                  ],
                ),
                crossFadeState:
                    listTodoNotifier.value.isEmpty
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: Duration(microseconds: 300),
              ),
            ),
          );
        },
      ),
    );
  }
}