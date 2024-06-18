import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class ResetPassWord extends StatefulWidget {

  const ResetPassWord({super.key});

  @override
  State<ResetPassWord> createState() => _ResetPassWordState();
}

class _ResetPassWordState extends State<ResetPassWord> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Reset Password",
              style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body:Column(
            children: [
              const SizedBox(height: 20,),
              Center(child: Text('Please enter your new password below',style: GoogleFonts.workSans(color: const Color.fromRGBO(96, 96, 96, 1),fontSize:16,fontWeight: FontWeight.w500),)),
              const SizedBox(height: 30,),
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
              const SizedBox(height: 20,),
              SizedBox(
                height: 52,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordController2,
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
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {

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
                    'Reset',
                    style: GoogleFonts.workSans(fontSize: 16, fontWeight: FontWeight.w500, color: const Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),

              )
            ],
          ),
        )
    );
  }
}

