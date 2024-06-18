import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/core/auth/sign_up_screen.dart';
import 'package:logmax/core/colors.dart';
import 'package:logmax/data/auth_data/login_data/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottombar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
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
          MaterialPageRoute(builder: (context) => const BottomBar(tabIndex: 0,)),
        );
      }
    }
  }

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isFirstContainerSelected = true;

  void _toggleSelection(bool isFirstContainer) {
    setState(() {
      _isFirstContainerSelected = isFirstContainer;
    });
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
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                // Ensure context is still valid before navigating
                if (mounted) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomBar(tabIndex: 0,)));
                }
              } else if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                const Image(image: AssetImage('assets/images/Logmax-PNG.png'), height: 35, width: 125,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Welcome Back!', style: GoogleFonts.workSans(fontSize: 20, fontWeight: FontWeight.w600, color: const Color.fromRGBO(0, 0, 0, 1))),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Please log in to continue', style: GoogleFonts.workSans(fontSize: 16, fontWeight: FontWeight.w500, color: const Color.fromRGBO(0, 0, 0, 1))),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _toggleSelection(true),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        onTap: () => _toggleSelection(false),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                    :  const Color.fromRGBO(108, 117, 125, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  height: 52,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: mobileController,
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
                        hintStyle: GoogleFonts.workSans(fontSize: 14, fontWeight: FontWeight.w500, color: const Color.fromRGBO(152, 152, 152, 1)),
                        prefixIcon: const Icon(Icons.phone, color: appColor,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  height: 52,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passwordController,
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
                const SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      final loginUser = mobileController.text;
                      final loginPass = passwordController.text;
                      print('Login: $loginUser, Password: $loginPass');

                      if (loginUser.isNotEmpty && loginPass.isNotEmpty) {
                        setState(() {
                          _isLoading = true; // Set isLoading to true when login process starts
                        });
                        loginBloc.add(LoginUserEvent(loginUser: loginUser, loginPass: loginPass));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter both mobile number and password')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      'Login',
                      style: GoogleFonts.workSans(fontSize: 16, fontWeight: FontWeight.w500, color: const Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool _isLoading = false;
}
