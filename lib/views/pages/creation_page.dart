import 'package:flutter/material.dart';

class CreationPage extends StatelessWidget {
  const CreationPage({super.key});

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
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
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
}