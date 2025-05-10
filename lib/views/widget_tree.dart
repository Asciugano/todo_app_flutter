import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/pages/creation_page.dart';
import 'package:todo_app_flutter/views/pages/home_page.dart';
import 'package:todo_app_flutter/views/pages/profile_page.dart';
import 'package:todo_app_flutter/views/pages/setting_page.dart';
import 'package:todo_app_flutter/views/pages/todo_page.dart';
import 'package:todo_app_flutter/views/widgets/navbar_widget.dart';

List<Widget> pages = [HomePage(), TodoPage(), ProfilePage()];

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
                  MaterialPageRoute(builder: (context) => SettingPage()),
                ),
            icon: Icon(Icons.settings),
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
                child: Icon(Icons.add),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreationPage()),
                    ),
              )
              : SizedBox.shrink(key: ValueKey('no-fab')),
    );
  }
}