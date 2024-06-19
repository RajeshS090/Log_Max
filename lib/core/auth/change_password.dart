import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String phoneNumber;

  ChangePasswordScreen({required this.phoneNumber});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isLoading = false;

  void _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Ensure the user is signed in
      User? user = _auth.currentUser;
      if (user == null) {
        throw 'User not signed in';
      }

      // Update the password in Firebase Authentication
      await user.updatePassword(_newPasswordController.text);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );

      // Sign out the user after password change
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Navigate to login screen or another appropriate screen
      Navigator.pop(context); // Assuming you want to go back to the previous screen
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to change password: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your new password:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              child: _isLoading ? CircularProgressIndicator() : Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
