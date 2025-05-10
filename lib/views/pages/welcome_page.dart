import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
            Expanded(child: Container()),
            SafeArea(
              child: Column(
                children: [
                  FilledButton(
                    onPressed:
                        () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => WidgetTree()),
                          (route) => false,
                        ),
                    style: FilledButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Get Started'),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed:
                        () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => WidgetTree()),
                          (route) => false,
                        ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}