import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/pages/creation_page.dart';
import 'package:todo_app_flutter/views/pages/home_page.dart';
import 'package:todo_app_flutter/views/pages/todo_page.dart';
import 'package:todo_app_flutter/views/widgets/navbar_widget.dart';

List<Widget> pages = [HomePage(), TodoPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreationPage()),
                ),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
      body: ValueListenableBuilder(
        valueListenable: currentPageNotifier,
        builder: (context, currentPage, child) {
          return pages[currentPageNotifier.value];
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreationPage()),
            ),
      ),
    );
  }
}