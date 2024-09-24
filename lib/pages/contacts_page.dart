import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:text_app_challenge/list/contact_list.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          backgroundColor: Colors.amber,
        ),
        body: const ContactListScreen());
  }
}
