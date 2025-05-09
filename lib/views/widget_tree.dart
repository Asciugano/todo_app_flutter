import 'package:flutter/material.dart';
import 'package:todo_app_flutter/views/widgets/navbar_widget.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('WidgetTree'),),
      bottomNavigationBar: Navbar(),
    );
  }
}