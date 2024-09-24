import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:text_app_challenge/models/contacts.dart';
import 'package:text_app_challenge/pages/NewContactForm.dart';
import 'dart:convert';

import 'package:text_app_challenge/pages/message_window.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    // Load your contacts from the JSON file
  }

  void _addContact(Contact newContact) {
    setState(() {
      contacts.add(newContact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          contacts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(contact.imageUrl),
                      ),
                      title: Text('${contact.firstName} ${contact.lastName}'),
                      subtitle: Text(contact.phoneNumber),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MessageWindow(contactName: contact.firstName),
                          ),
                        );
                      },
                    );
                  },
                ),
          Positioned(
            top: 0,
            right: 20.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                // Navigate to ContactFormScreen and pass the current contacts list
                final newContact = await Navigator.push<Contact>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactFormScreen(
                      existingContacts: contacts,
                    ),
                  ),
                );

                // Add the new contact if it's not null
                if (newContact != null) {
                  _addContact(newContact);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Contact'),
              tooltip: 'Add Contact',
            ),
          ),
        ],
      ),
    );
  }
}
