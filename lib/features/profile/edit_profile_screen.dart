import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bottombar.dart';
import '../../data/profile_data/profile_update_data/profile_update_bloc.dart';

import '../../core/colors.dart';

class EditProfile extends StatefulWidget {
  final String userId;
  final String name;
  final String email;
  final String phone;

   EditProfile({
    Key? key,
    required this.name,
    required this.email,
    required this.phone, required this.userId,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late ProfileUpdateBloc profileUpdateBloc;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    profileUpdateBloc = BlocProvider.of<ProfileUpdateBloc>(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void updateProfile() {
    profileUpdateBloc.add(ProfileUpdate(
      txtId: widget.userId, // Replace with actual user ID or dynamically fetch it
      txtName: nameController.text,
      txtEmail: emailController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Edit Profile",
            style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            onPressed: updateProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              'Update',
              style: GoogleFonts.workSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.message),
                ),
              );
              Navigator.push(context,MaterialPageRoute(builder: (context) => const BottomBar(tabIndex: 2,)));
            } else if (state is ProfileUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.errorMessage),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image(
                            image: AssetImage('assets/images/profile-pic.webp'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromRGBO(238, 137, 36, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Name',
                    hintStyle: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(152, 152, 152, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Mobile Number',
                    hintStyle: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(152, 152, 152, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(152, 152, 152, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
