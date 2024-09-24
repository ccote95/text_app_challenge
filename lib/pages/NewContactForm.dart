import 'package:flutter/material.dart';
import 'package:text_app_challenge/models/contacts.dart';

class ContactFormScreen extends StatefulWidget {
  final List<Contact> existingContacts;
  const ContactFormScreen({super.key, required this.existingContacts});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Contact'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  //Calculate the new Id based on the number of existing contacts
                  final newId = widget.existingContacts.length + 1;
                  //Create the new Contact
                  final newContact = Contact(
                    id: newId,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    phoneNumber: _phoneNumberController.text,
                    imageUrl: _imageUrlController.text.isNotEmpty
                        ? _imageUrlController.text
                        : 'https://via.placeholder.com/150', //fall back image
                  );
                  Navigator.pop(context, newContact);
                },
                child: const Text('Add Contact'),
              )
            ],
          ),
        ));
  }
}
