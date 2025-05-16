import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/classes/priority_level.dart';
import 'package:todo_app_flutter/data/classes/todo_item.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({super.key, this.item});

  final TodoItem? item;

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? scadenza;
  PriorityLevel? selectedPriority;
  String? menuItem = 'P2';

  void initComponets() {
    if (widget.item != null) {
      titleController.text = widget.item!.title;
      descriptionController.text = widget.item!.desctiption;
      scadenza = widget.item!.scadenza;
      selectedPriority = widget.item!.priorityLevel;
    }
  }

  @override
  Widget build(BuildContext context) {
    initComponets();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Title',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Description',
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  scadenza = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                },
                child: Text('Scadenza'),
              ),
              DropdownButton(
                value: menuItem,
                items: [
                  DropdownMenuItem(
                    value: 'P1',
                    child: Text(PriorityLevel.low.label),
                  ),
                  DropdownMenuItem(
                    value: 'P2',
                    child: Text(PriorityLevel.medium.label),
                  ),
                  DropdownMenuItem(
                    value: 'P3',
                    child: Text(PriorityLevel.high.label),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (canCreateItem()) {
                          widget.item != null ? updateIem() : createItem();
                          Navigator.pop(context);
                        }
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text('Create'),
                    ),
                  ),
                  SizedBox(width: 7),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool canCreateItem() {
    if (titleController.text == '' || descriptionController.text == '') {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Errore'),
              content: Text('Devi inserire tutti i campi'),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(double.infinity, 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ],
            ),
      );
      return false;
    }
    return true;
  }

  void updateIem() {
    if (widget.item != null) {
      int i = todoListNotifier.value.indexOf(widget.item!);
      final TodoItem changedTodo = TodoItem(
        title: titleController.text,
        desctiption: descriptionController.text,
        isCompleted: widget.item!.isCompleted,
        creationTime: widget.item!.creationTime,
        priorityLevel: selectedPriority ?? PriorityLevel.medium,
      );

      final updatedList = [...todoListNotifier.value];
      updatedList[i] = changedTodo;
      todoListNotifier.value = updatedList;

      saveTodo();
    }
  }

  void createItem() {
    TodoItem newTodo = TodoItem(
      title: titleController.text,
      desctiption: descriptionController.text,
      isCompleted: false,
      creationTime: DateTime.now(),
      priorityLevel: selectedPriority ?? PriorityLevel.medium,
      scadenza: scadenza,
    );

    todoListNotifier.value = [...todoListNotifier.value, newTodo];
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