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
  int? selectedContactIndex;

  @override
  void initState() {
    super.initState();
    loadContacts(); // Load contacts from the JSON file
  }

  Future<void> loadContacts() async {
    try {
      // Load the contacts data from the JSON file
      final String response = await rootBundle.loadString('assets/data.json');
      final Map<String, dynamic> decodedData = json.decode(response);

      // Extract the list of contacts from the 'users' field
      final List<dynamic> contactsData = decodedData['users'] as List<dynamic>;

      setState(() {
        // Convert each contact's JSON data into a Contact object
        contacts = contactsData.map((json) => Contact.fromJson(json)).toList();
      });
    } catch (error) {
      print('Error loading contacts: $error');
    }
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
                    bool isSelected = selectedContactIndex == index;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedContactIndex =
                              index; // Track selected contact
                        });

                        // Navigate to the message window when a contact is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageWindow(
                              contactName: contact.firstName,
                            ),
                          ),
                        ).then((_) {
                          setState(() {
                            selectedContactIndex = null;
                          });
                        });
                      },
                      child: Container(
                        // Apply gradient if the contact is selected
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(
                                  colors: [Colors.blueAccent, Colors.lightBlue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null, // No gradient if not selected
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(contact.imageUrl),
                          ),
                          title:
                              Text('${contact.firstName} ${contact.lastName}'),
                          subtitle: Text(contact.phoneNumber),
                        ),
                      ),
                    );
                  },
                ),
          Positioned(
            top: 10,
            right: 20.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                // Navigate to ContactFormScreen to add a new contact
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
