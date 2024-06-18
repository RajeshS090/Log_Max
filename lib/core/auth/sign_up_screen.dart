import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/core/auth/reset_password_screen.dart';
import 'package:logmax/core/colors.dart';
import 'package:logmax/data/auth_data/login_data/login_bloc.dart';
import 'package:logmax/data/auth_data/sign_up_data/sign_up_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_service/authentication.dart';
import '../auth_service/fire_storage.dart';
import '../bottombar.dart';
import 'forgot_password.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late LoginBloc loginBloc;
  late SignUpBloc signUpBloc;

  final PageController _pageController = PageController();
  final TextEditingController loginMobileController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpMobileController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  final TextEditingController signUpConfirmPasswordController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool _isLoading = false;
  bool _isFirstContainerSelected = true;
  final TextEditingController _phoneController = TextEditingController();
  // final Otpless _otplessFlutterPlugin = Otpless();
  String phoneNumber2 = '919629633404'; // Ensure this includes the country code

  // void _requestOtp() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   var arg = {
  //     'appId': "BQ700FOUQM2TL832QZ6M",
  //   };
  //
  //
  //   _otplessFlutterPlugin.openLoginPage((result) {
  //     print("🤣🤣🤣🤣🤣$result");
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     if (result['data'] != null) {
  //       final data = result['data'];
  //       final token = data['token'];
  //       final identities = data['identities'];
  //
  //       print("😒😒$identities");
  //
  //       String? phoneNumber;
  //       if (identities is List) {
  //         for (var identity in identities) {
  //           if (identity['identityType'] == 'MOBILE') {
  //             phoneNumber = identity['identityValue'];
  //             break;
  //           }
  //         }
  //       }
  //
  //       phoneNumber = phoneNumber?.trim();
  //       phoneNumber2 = phoneNumber2.trim();
  //
  //       if (phoneNumber != null && phoneNumber.startsWith('91')) {
  //         phoneNumber = phoneNumber.substring(2);
  //       }
  //       if (phoneNumber2.startsWith('91')) {
  //         phoneNumber2 = phoneNumber2.substring(2);
  //       }
  //
  //       print("😒vvvvv😒$phoneNumber");
  //       print(
  //           "Comparing: phoneNumber2=$phoneNumber2 with phoneNumber=$phoneNumber");
  //
  //       if (phoneNumber != null && phoneNumber2 == phoneNumber) {
  //         print('Extracted Phone Number: $phoneNumber');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('OTP sent successfully')),
  //         );
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) =>
  //             const ResetPassWord(
  //               // phone: phoneNumber,
  //             ),
  //           ),
  //         );
  //       } else {
  //         print('👌👌👌👌Phone number not found in identities');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('You are not registered')),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(result['errorMessage'])),
  //       );
  //     }
  //   }, arg);
  // }


  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final userType = prefs.getString('userType');

    if (userId != null && userType != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomBar(tabIndex: 0,)),
        );
      }
    }
  }

  void _toggleSelection(bool isFirstContainer) {
    setState(() {
      _isFirstContainerSelected = isFirstContainer;
    });
    _pageController.animateToPage(
      isFirstContainer ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildHeaderContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Center(
            child: Text(
              _isFirstContainerSelected
                  ? 'Welcome Back!'
                  : 'Create a new account',
              style: GoogleFonts.workSans(fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
          const SizedBox(height: 10,),
          Center(
            child: Text(
              _isFirstContainerSelected
                  ? 'Please log in to continue'
                  : 'Please fill in the details to sign up',
              style: GoogleFonts.workSans(fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 40,),
                  const Image(image: AssetImage('assets/images/Logmax-PNG.png'),
                    height: 35,
                    width: 125,),
                  _buildHeaderContent(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _toggleSelection(true);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _isFirstContainerSelected
                                  ? const Color.fromRGBO(254, 205, 4, 1)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: GoogleFonts.workSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: _isFirstContainerSelected
                                      ? Colors.black
                                      : const Color.fromRGBO(108, 117, 125, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _toggleSelection(false);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: !_isFirstContainerSelected
                                  ? const Color.fromRGBO(254, 205, 4, 1)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.workSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: !_isFirstContainerSelected
                                      ? Colors.black
                                      : const Color.fromRGBO(108, 117, 125, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildLoginPage(),
                        _buildSignUpPage(),
                      ],
                    ),
                  ),
                ],
              ),
              if (_isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPage() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() {
            _isLoading = true; // Show loading overlay
          });
        } else if (state is LoginSuccess || state is LoginError) {
          setState(() {
            _isLoading = false; // Hide loading overlay
          });

          if (state is LoginSuccess) {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomBar(tabIndex: 0,)),
              );
            }
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                content: Text(state.error),
              ),
            );
          }
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                child: TextField(
                  controller: loginMobileController,
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
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                child: TextField(
                  controller: loginPasswordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appColor),
                    ),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(152, 152, 152, 1),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: appColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: appColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // _requestOtp();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>  const ForgotPasswordScreen())
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.workSans(fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: appColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.workSans(fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSignUpPage() {
    bool _passwordsMatch = true; // Assuming this is used to validate password match
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                child: TextField(
                  controller: signUpNameController,
                  // maxLength: 10,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appColor),
                    ),
                    hintText: 'Name',
                    hintStyle: GoogleFonts.workSans(fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(152, 152, 152, 1)),
                    prefixIcon: const Icon(Icons.person, color: appColor,),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                child: TextField(
                  controller: signUpEmailController,
                  // maxLength: 10,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appColor),
                    ),
                    hintText: 'email',
                    hintStyle: GoogleFonts.workSans(fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(152, 152, 152, 1)),
                    prefixIcon: const Icon(Icons.email, color: appColor,),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                child: TextField(
                  controller: signUpMobileController,
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                child: TextField(
                  controller: signUpPasswordController,
                  obscureText: _isObscure1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appColor),
                    ),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(152, 152, 152, 1),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: appColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure1 ? Icons.visibility_off : Icons.visibility,
                        color: appColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure1 = !_isObscure1;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07,
                child: TextField(
                  controller: signUpConfirmPasswordController,
                  obscureText: _isObscure2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appColor),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(152, 152, 152, 1),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: appColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure2 ? Icons.visibility_off : Icons.visibility,
                        color: appColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (!_passwordsMatch)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Passwords do not match.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ElevatedButton(
                    onPressed: signupUser,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: appColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (_isLoading)
                    const Positioned(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signupUser() async {
    final authMethod = AuthMethod();

    // Extract text from controllers
    String email = signUpEmailController.text.trim();
    String password = signUpPasswordController.text.trim();
    String confirmPassword = signUpConfirmPasswordController.text.trim();
    String name = signUpNameController.text.trim();
    String mobile = signUpMobileController.text.trim();

    // Check if any of the required fields are empty
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty || mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('All fields are required'),
        ),
      );
      return;
    }

    // Check if password and confirm password match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Call Firebase signup method
    String result = await authMethod.signupUser(
      email: email,
      password: password,
      name: name,
      mobile: mobile,
    );

    setState(() {
      _isLoading = false;
    });

    // Process result
    if (result == 'success') {
      FocusScope.of(context).unfocus();
      try {
        // Fetch user data using the extracted email
        DocumentSnapshot userSnapshot = await authMethod.getUserData(email);
        await processFirestoreData(userSnapshot);

        // Clear the controllers after successfully fetching and processing the user data
        signUpEmailController.clear();
        signUpNameController.clear();
        signUpMobileController.clear();
        signUpPasswordController.clear();
        signUpConfirmPasswordController.clear();

        _isFirstContainerSelected = true;
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            content: Text('User Created Successfully'),
          ),
        );
      } catch (e) {
        print('Error fetching user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('Error fetching user data: $e'),
          ),
        );
      }
    } else {
      // Show error message returned from signupUser method
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }



  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    // signup user using our auth method
    String res = await AuthMethod().loginUser(
    mobile: loginMobileController.text,password: loginPasswordController.text,);
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      //navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomBar(tabIndex: 0),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
      print(res);
    }
  }

}
