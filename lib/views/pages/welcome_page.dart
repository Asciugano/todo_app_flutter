import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/welcome.json'),
            SizedBox(height: 10),
            FittedBox(
              child: Text(
                'TODO APP',
                style: TextStyle(
                  color: themeColorNotifier.value,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  letterSpacing: 50,
                ),
              ),
            ),
            Expanded(child: Container()),
            SafeArea(
              child: FilledButton(
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WidgetTree()),
                    (route) => false,
                  );
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool(KKeys.showWelcome, false);
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}