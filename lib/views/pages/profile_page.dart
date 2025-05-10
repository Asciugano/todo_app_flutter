import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/notifiers.dart';
import 'package:todo_app_flutter/views/pages/welcome_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 50),
        Expanded(child: Container()),
        SafeArea(
          child: Center(
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                  (route) => false,
                );
                currentPageNotifier.value = 0;
              },
            ),
          ),
        ),
      ],
    );
  }
}