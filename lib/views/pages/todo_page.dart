import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/notifiers.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              todoListNotifier.value.length,
              (i) => Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Title: ${todoListNotifier.value.elementAt(i)}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}