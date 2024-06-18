import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/core/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          appBar:AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title:  Text(
              "Notification",
              style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Today',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:18,fontWeight: FontWeight.w500),),
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      child:  Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:0,vertical:0),
                              child: CircleAvatar(
                                backgroundColor: const Color.fromRGBO(247, 239, 255, 1),
                                radius: 25,
                                child: SvgPicture.asset(
                                    'assets/images/product.svg',height: 30,
                                    color:appColor
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Shipment Update',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:16,fontWeight: FontWeight.w500),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Text('2 Hours ago',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:12,fontWeight: FontWeight.w400),),
                                    ),
                                  ],
                                ),
                                Text('Your package #123456 is out for delivery.',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:14,fontWeight: FontWeight.w400),),

                              ],
                            ),
                          )

                        ],
                      ),
                    );
                  },

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Yesterday',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:18,fontWeight: FontWeight.w500),),
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      child:  Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:0,vertical:0),
                              child: CircleAvatar(
                                backgroundColor: const Color.fromRGBO(255, 243, 242, 1),
                                radius: 25,
                                child: SvgPicture.asset(
                                    'assets/images/product.svg',height: 30,
                                    color:appColor
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Shipment Update',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:16,fontWeight: FontWeight.w500),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Text('2 Hours ago',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:12,fontWeight: FontWeight.w400),),
                                    ),
                                  ],
                                ),
                                Text('Your package #123456 is out for delivery.',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:14,fontWeight: FontWeight.w400),),

                              ],
                            ),
                          )

                        ],
                      ),
                    );
                  },

                ),
              ],
            ),
          ),
        )
    );
  }
}
