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
    setState(() {
      _isLoading = true;
    });

    try {
      // Check if the mobile number exists in Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('mobile', isEqualTo: _mobileController.text)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Mobile number exists, proceed with sending OTP
        await _auth.verifyPhoneNumber(
          phoneNumber: '+91${_mobileController.text}', // Replace with your country code and mobile number format
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Auto-retrieve OTP on Android
            await _auth.signInWithCredential(credential);
            // Handle verification success
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
            // Navigate to OTP verification screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OtpVerificationScreen(verificationId: verificationId, phoneNumber: '+91${_mobileController.text}',),
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
  var verificationId;
  var phoneNumber;

   OtpVerificationScreen({super.key, required this.verificationId, required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with CodeAutoFill {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _otpCode = '';
  bool _isResending = false;

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
              const SizedBox(height: 20),
              TextButton(
                onPressed: _isResending ? null : _resendOtp,
                child: Text(
                  _isResending ? 'Resending...' : 'Resend OTP',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _isResending
                        ? Colors.grey
                        : appColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          builder: (context) =>
              ChangePasswordScreen(userId: widget.verificationId),
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

  void _resendOtp() async {
    setState(() {
      _isResending = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isResending = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed to resend OTP: ${e.message}'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isResending = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP resent successfully')),
          );
          // Update the verification ID with the new one
          widget.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      setState(() {
        _isResending = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to resend OTP: $e'),
        ),
      );
    }
  }
}
