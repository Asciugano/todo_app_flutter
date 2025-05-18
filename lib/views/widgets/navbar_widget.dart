import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.list), label: 'Lists'),
            NavigationDestination(icon: Icon(Icons.check), label: 'Todo'),
            // NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
          selectedIndex: currentPage,
          onDestinationSelected: (value) {
            currentPageNotifier.value = value;
            if (currentPageNotifier.value == KPage.todoPageIndex) {
              currentListIDNotifier.value = null;
            }
          },
        );
      },
    );
  }
}