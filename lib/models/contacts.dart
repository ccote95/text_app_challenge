class Contact {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String imageUrl;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.imageUrl,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
    );
  }
}
