import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';

class MyCouriers extends StatefulWidget {
  const MyCouriers({super.key});

  @override
  State<MyCouriers> createState() => _MyCouriersState();
}

class _MyCouriersState extends State<MyCouriers> {
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
              "Support",
              style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: const SingleChildScrollView(
            child: Column(
              children: [

              ],
            ),
          ),
        )
    );
  }
}
