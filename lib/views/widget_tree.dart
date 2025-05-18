import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/classes/list_todo.dart';
import 'package:todo_app_flutter/data/utils.dart';
import 'package:todo_app_flutter/views/pages/welcome_page.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/pages/creation_page.dart';
import 'package:todo_app_flutter/views/pages/list_page.dart';
import 'package:todo_app_flutter/views/pages/setting_page.dart';
import 'package:todo_app_flutter/views/pages/todo_page.dart';
import 'package:todo_app_flutter/views/widgets/navbar_widget.dart';

List<Widget> pages = [HomePage(), TodoPage() /* , ProfilePage() */];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo App'),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                ),
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
                (route) => false,
              );
              currentPageNotifier.value = 0;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool(KKeys.showWelcome, true);
            },
            icon: Icon(Icons.logout),
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
      floatingActionButton: ValueListenableBuilder(
        valueListenable: currentPageNotifier,
        builder: (context, currentPage, child) {
          final action = buildAddButton(context, currentPage);
          return action ?? SizedBox.shrink();
        },
      ),
    );
  }

  Widget? buildAddButton(BuildContext context, int currentPage) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder:
          (child, animation) => ScaleTransition(scale: animation, child: child),
      child:
          currentPage != KPage.profilePageIndex
              ? FloatingActionButton(
                onPressed:
                    currentPage == KPage.todoPageIndex
                        ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreationPage(),
                          ),
                        )
                        : () {
                          TextEditingController controller =
                              TextEditingController();
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('Creazione lista'),
                                  content: TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      hintText: 'Titolo della lista...',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    FilledButton(
                                      onPressed: () async {
                                        ListTodo newList = ListTodo(
                                          title: controller.text.trim(),
                                          id: await Utils.getCurrentID() + 1,
                                        );
                                        listTodoNotifier.value = [
                                          ...listTodoNotifier.value,
                                          newList,
                                        ];
                                        final prefs =
                                            await SharedPreferences.getInstance();
                                        final List<String> jsonListTodo =
                                            listTodoNotifier.value
                                                .map(
                                                  (list) =>
                                                      jsonEncode(list.toJson()),
                                                )
                                                .toList();
                                        await prefs.setStringList(
                                          KKeys.jsonListTodo,
                                          jsonListTodo,
                                        );
                                        Utils.setCurrentID(newList.id);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Crea'),
                                    ),
                                  ],
                                ),
                          );
                        },
                child: Icon(Icons.add),
              )
              : SizedBox.shrink(key: ValueKey('no-fab')),
    );
  }
}