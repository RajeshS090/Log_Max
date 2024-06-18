import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Function to add user data to Firestore
Future<DocumentSnapshot<Object?>> addUserToFirestore(String userId, String email, String name) async {
  try {
    // Reference to Firestore collection 'users'
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Add a new document with a generated ID
    await users.doc(userId).set({
      'email': email,
      'name': name,
      'createdAt': Timestamp.now(),
    });

    // Return the document snapshot for further processing
    return await users.doc(userId).get(); // This retrieves the document after it's added
  } catch (e) {
    // Handle error
    throw Exception('Failed to add user to Firestore: $e');
  }
}

// Function to process the retrieved document from Firestore
Future<void> processFirestoreData(DocumentSnapshot document) async {
  try {
    // Assuming you want to store the retrieved data in your own database or perform other actions
    String userId = document.id;
    String userEmail = document['email'];
    String userName = document['name'];
    String mobile = document['mobile'];
    String password = document['password'];
    // Add your logic here to store this data into your own database
    // Example: use another service or API call to store this data into MySQL, PostgreSQL, etc.
    // For demonstration purpose, you can just print the data here
    print('Retrieved Firestore Data:');
    print('User ID: $userId');
    print('Email: $userEmail');
    print('Name: $userName');
    print('mobile: $mobile');
    print('password: $password');
  } catch (e) {
    // Handle error
    print('Error processing Firestore data: $e');
  }
}