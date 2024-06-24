import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/core/colors.dart';
import 'package:logmax/features/home/track_courier/track_view_screen.dart';

class TrackCourierListScreen extends StatefulWidget {
  const TrackCourierListScreen({super.key});

  @override
  State<TrackCourierListScreen> createState() => _TrackCourierListScreenState();
}

class _TrackCourierListScreenState extends State<TrackCourierListScreen> {
  DateTime preBackPress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
            }
            else {
              await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
            return false;
          },
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            appBar:AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Track Courier",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context) => const TrackViewScreen()));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ]
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      child: SvgPicture.asset(
                                        'assets/images/product.svg',height: 30,
                                        color:appColor
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:0,vertical: 10),
                                      child: Text('Tracking ID : ',style: GoogleFonts.workSans(fontSize: 15,fontWeight: FontWeight.w400,color: const Color.fromRGBO(108, 117, 125, 1)),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:0,vertical: 10),
                                      child: Text('5122333',style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w400,color: const Color.fromRGBO(0, 0, 0, 1)),),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 0,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:20,),
                                      child: Text('Tracking ID : ',style: GoogleFonts.workSans(fontSize: 15,fontWeight: FontWeight.w400,color: const Color.fromRGBO(108, 117, 125, 1)),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:0,vertical: 10),
                                      child: Text('5122333',style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w400,color: const Color.fromRGBO(0, 0, 0, 1)),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
