import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../colors.dart';
import 'change_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          title:  Text('Forgot Password',style:GoogleFonts.workSans(fontSize:20,fontWeight: FontWeight.w600,color: const Color.fromRGBO(0, 0, 0, 1))),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('Please enter your registered phone number to reset your password',style: GoogleFonts.workSans(fontSize: 14,fontWeight: FontWeight.w500,color: const Color.fromRGBO(152, 152, 152, 1)),textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:0),
                child: SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                  child: TextField(
                    controller: _mobileController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: appColor),
                      ),
                      hintText: 'Mobile Number',
                      hintStyle: GoogleFonts.workSans(fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(152, 152, 152, 1)),
                      prefixIcon: const Icon(Icons.phone, color: appColor,),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _checkAndSendOtp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(_isLoading ? 'Checking...' : 'Send OTP',style: GoogleFonts.workSans(fontSize: 14,fontWeight: FontWeight.w500,color: const Color.fromRGBO(255, 255, 255, 1)),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAndSendOtp() async {
    print('Searching for mobile number: ${_mobileController.text}');
    setState(() {
      _isLoading = true;
    });

    try {
      String formattedMobile = '+91${_mobileController.text}'; // Ensure the correct format

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('mobile', isEqualTo: formattedMobile)
          .limit(1)
          .get();
      querySnapshot.docs.forEach((doc) {
        print('Document ID: ${doc.id}');
        print('Document data: ${doc.data()}');
        print('Document exists: ${doc.exists}');
      });
      if (querySnapshot.docs.isNotEmpty) {
        await _auth.verifyPhoneNumber(
          phoneNumber: formattedMobile,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP verification successful')),
            );
          },
          verificationFailed: (FirebaseAuthException e) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Failed to send OTP: ${e.message}'),
              ),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP sent successfully')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                  verificationId: verificationId,
                  phoneNumber: formattedMobile,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP retrieval timeout')),
            );
          },
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Mobile number is not registered.'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to check and send OTP: $e'),
        ),
      );
    }
  }


}
class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  OtpVerificationScreen({super.key, required this.verificationId, required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> with CodeAutoFill {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void codeUpdated() {
    setState(() {
      _otpCode = code!;
    });

    if (_otpCode.length == 6) {
      _verifyOtp();
    }
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  void _verifyOtp() async {
    if (_otpCode.isEmpty || _otpCode.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpCode,
      );

      await _auth.signInWithCredential(credential);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verification successful')),
      );

      // After OTP verification, proceed to the change password screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(phoneNumber: widget.phoneNumber),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to verify OTP: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          title: Text(
            'Verify your Account',
            style: GoogleFonts.workSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Please enter the verification code sent to your phone number',
                style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(96, 96, 96, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              OtpTextField(
                numberOfFields: 6,
                borderColor: const Color.fromRGBO(238, 119, 35, 1),
                focusedBorderColor: const Color.fromRGBO(238, 119, 35, 1),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String code) {
                  setState(() {
                    _otpCode = code;
                  });
                  _verifyOtp();
                },
                textStyle: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: appColor, // Update to match your app color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  _isLoading ? 'Verifying...' : 'Verify OTP',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
