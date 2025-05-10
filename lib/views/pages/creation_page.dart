import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/classes/priority_level.dart';
import 'package:todo_app_flutter/data/classes/todo_item.dart';
import 'package:todo_app_flutter/data/notifiers.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? scadenza;
  PriorityLevel? selectedPriority;
  String? menuItem = 'P2';

  @override
  Widget build(BuildContext context) {
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
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
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
                        if(canCreateItem()) {
                          createItem();
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
    if(titleController.text == '' || descriptionController.text == '') {
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
  
  void createItem() {
    TodoItem newTodo = TodoItem(
      title: titleController.text,
      desctiption: descriptionController.text,
      creationTime: DateTime.now(),
      priorityLevel: selectedPriority ?? PriorityLevel.medium,
    );
    
    todoListNotifier.value.add(newTodo);
  }

}