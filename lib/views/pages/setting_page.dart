import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/widgets/color_picker.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: ThemeColorPicker(
              initialColor: Colors.yellow,
              onColorSelected: (color) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt(KKeys.themeColorKey, color.value);
                
                themeColorNotifier.value = color;
              },
            ),
          ),
        ],
      ),
    );
  }
}