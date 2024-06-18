import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logmax/core/auth/sign_up_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String userId;

  const ChangePasswordScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter new password',
                labelText: 'New Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              child: Text(_isLoading ? 'Changing Password...' : 'Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updatePassword(_newPasswordController.text);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'password': _newPasswordController.text});

        print(user.uid);

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      } else {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found. Please login again.')),
        );
      }
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
}
