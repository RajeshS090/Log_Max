import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isSwitched1 = true;
  bool isSwitched2 = false;
  bool isSwitched3 = true;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
            title:  Text(
              "Notification Settings",
              style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 20,),
              ListTile(
                title: Text(
                  "Push Notifications",
                  style: GoogleFonts.workSans(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  value: isSwitched1,
                  onChanged: (value) {
                    setState(() {
                      isSwitched1 = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Email Notifications",
                  style: GoogleFonts.workSans(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  value: isSwitched2,
                  onChanged: (value) {
                    setState(() {
                      isSwitched2 = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "SMS Notifications",
                  style: GoogleFonts.workSans(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  value: isSwitched3,
                  onChanged: (value) {
                    setState(() {
                      isSwitched3 = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
