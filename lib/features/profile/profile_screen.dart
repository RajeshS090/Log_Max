import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/auth/login_screen.dart';
import '../../core/auth/sign_up_screen.dart';
import '../../data/profile_data/profile_get_data/profile_get_bloc.dart';
import '../../data/profile_data/profile_get_data/profile_get_event.dart';
import '../../data/profile_data/profile_get_data/profile_get_state.dart';
import '../../model/profile_model/profile_get_model.dart';
import 'edit_profile_screen.dart';
import 'my_address_screen.dart';
import 'my_couriers_screen.dart';
import 'notification_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Dio dio = Dio();
  late ProfileGetBloc userProfileBloc;
  late String userId;

  // @override
  // void initState() {
  //   super.initState();
  //   userProfileBloc = BlocProvider.of<ProfileGetBloc>(context);
  //   fetchUserId();
  // }

  Future<void> fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    userProfileBloc.add(FetchUserProfile(userId: userId));
    print('User ID: $userId');
  }


  DateTime preBackPress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (now.difference(preBackPress) > const Duration(seconds: 2)) {
            preBackPress = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
                content: Text('Press back again to exit'),
              ),
            );
          } else {
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Profile",
              style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<ProfileGetBloc, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserProfileSuccess) {
                final profile = state.userProfile;
                print("Profile: $profile");
                return buildProfileContent();
              } else if (state is UserProfileError) {
                print("Error: ${state.errorMessage}");
                return Center(child: Text('Error: ${state.errorMessage}'));

              } else {
                return buildProfileContent();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildProfileContent() {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CircleAvatar(
                radius: 40,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage("assets/images/profile-pic.webp"),
                  ),
                ),
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       profile.textName ?? '',
            //       style: GoogleFonts.workSans(
            //           color: const Color.fromRGBO(0, 0, 0, 1),
            //           fontSize: 18,
            //           fontWeight: FontWeight.w600
            //       ),
            //     ),
            //     Text(
            //       profile.textMobile ?? '',
            //       style: GoogleFonts.workSans(
            //           color: const Color.fromRGBO(108, 117, 125, 1),
            //           fontSize: 16,
            //           fontWeight: FontWeight.w600
            //       ),
            //     ),
            //     Text(
            //       profile.textEmail ?? '',
            //       style: GoogleFonts.workSans(
            //           color: const Color.fromRGBO(108, 117, 125, 1),
            //           fontSize: 16,
            //           fontWeight: FontWeight.w600
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
        const SizedBox(height: 20,),
        ListTile(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProfile(name: profile.textName, email:profile.textEmail, phone:profile.textMobile, userId:userId, )));
          },
          leading: const Icon(Icons.edit, color: Color.fromRGBO(0, 0, 0, 1),),
          title: Text("Edit Profile", style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(0, 0, 0, 1), size: 30,),
        ),
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCouriers()));
          },
          leading: const Icon(Icons.support, color: Color.fromRGBO(0, 0, 0, 1),),
          title: Text("Support", style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(0, 0, 0, 1), size: 30,),
        ),
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAddress()));
          },
          leading: const Icon(Icons.location_on, color: Color.fromRGBO(0, 0, 0, 1),),
          title: Text("My Addresses", style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(0, 0, 0, 1), size: 30,),
        ),
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationSettings()));
          },
          leading: const Icon(Icons.notifications, color: Color.fromRGBO(0, 0, 0, 1),),
          title: Text("Notification Settings", style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(0, 0, 0, 1), size: 30,),
        ),
        ListTile(
          leading: const Icon(Icons.description, color: Color.fromRGBO(0, 0, 0, 1),),
          title: Text("Terms and Conditions", style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(0, 0, 0, 1), size: 30,),
        ),
        ListTile(
          leading: const Icon(Icons.description, color: Color.fromRGBO(0, 0, 0, 1),),
          title: Text("Privacy and Policy", style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(0, 0, 0, 1), size: 30,),
        ),
        const SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
          child: ElevatedButton(onPressed: () {
            showDialogBox();
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckOutScreen()));
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text('Log Out', style: GoogleFonts.workSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),),
          ),
        ),
      ],
    );
  }

  void showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Logout',
              style: GoogleFonts.workSans(
                color: const Color.fromRGBO(38, 36, 34, 1),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.workSans(
              color: const Color.fromRGBO(38, 36, 34, 1),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(38, 36, 34, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(38, 36, 34, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                // Navigate to LoginScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
