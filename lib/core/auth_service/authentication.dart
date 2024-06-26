import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String mobile,
  }) async {
    try {
      // Check if the email is already in use
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the mobile number is already in use
      bool isMobileInUse = await _isMobileInUse(mobile);

      if (isMobileInUse) {
        // If the mobile number is already in use, delete the created user and return an error message
        await userCredential.user!.delete();
        return 'Error: The mobile number is already in use';
      }

      // Add country code to the mobile number before saving
      String formattedMobile = '+91' + mobile;
      await addUserToFirestore(
        userId: userCredential.user!.uid,
        email: email,
        name: name,
        mobile: formattedMobile,
        password: password,
      );

      return 'success';
    } on FirebaseAuthException catch (e) {
      return 'Error: ${e.message}';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<bool> _isMobileInUse(String mobile) async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').where('mobile', isEqualTo: mobile).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> addUserToFirestore({
    required String userId,
    required String email,
    required String name,
    required String mobile,
    required String password,
  }) async {
    try {
      CollectionReference users = _firestore.collection('users');
      await users.doc(userId).set({
        'email': email,
        'name': name,
        'mobile': mobile,
        'password': password,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to add user to Firestore: $e');
    }
  }

  Future<DocumentSnapshot> getUserData(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  Future<String> loginUser({
    required String mobile,
    required String password,
  }) async {
    try {
      if (mobile.isNotEmpty && password.isNotEmpty) {
        QuerySnapshot querySnapshot = await _firestore.collection('users').where('mobile', isEqualTo: mobile).get();

        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: userDoc['email'],
            password: password,
          );

          // Store user data in shared_preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', userDoc.id);
          await prefs.setString('userType', 'user'); // Assuming userType is 'user', adjust as necessary

          return "success";
        } else {
          return 'No user found for that mobile number.';
        }
      } else {
        return "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An unknown error occurred';
    } catch (e) {
      return 'An unknown error occurred';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    // Clear user data from shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
