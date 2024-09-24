import 'package:flutter/material.dart';
import 'package:text_app_challenge/main.dart';
import 'package:text_app_challenge/pages/contacts_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Builder(
          builder: (context) => ElevatedButton(
            child: const Text('Contacts'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactsPage()),
              );
            },
          ),
        )));
  }
}
