import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:logmax/features/home/track_courier/track_courier_screen.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../core/colors.dart';
import '../notification/notification_screen.dart';
import '../schedule_pickup/pickup_screen.dart';
import 'myshipment/shipment_details_screen.dart';
import 'myshipment/shipment_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function onExit;
  const HomeScreen({super.key, required this.onExit});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? currentLatitude;
  double? currentLongitude;
  String? currentAddress;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      widget.onExit(); // Exit the app
    } else if (permission == LocationPermission.deniedForever) {
      widget.onExit(); // Exit the app
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
      Placemark placemark = (await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      )).first;


      setState(() {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
        currentAddress = " ${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea},";
        print("Latitude: $currentLatitude, Longitude: $currentLongitude");
        print("Address: $currentAddress");
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      isLoading = false; // Set loading indicator to false in case of error
    }
  }
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  DateTime preBackPress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
        body: SmartRefresher(
          controller: _refreshController,
          physics: const BouncingScrollPhysics(),
          enablePullUp: false,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
            _getCurrentLocation();
          },
          child: Column(
            children: [
              Expanded(  // This ensures the container takes up available space dynamically
                flex: 4,  // Adjust the flex value as needed
                child: Stack(
                  children: [
                    Container(
                      height: 170,
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 38 ),
                      decoration: const BoxDecoration(
                        color: appColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 0),
                          Row(
                            children: [
                              isLoading
                                  ? const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,),
                                  )
                                  :
                               Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  radius: 21,
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                    'assets/images/location-icon.svg',
                                  )
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  currentAddress ?? "Fetching location...",
                                  style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                               Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder:(context) => const NotificationScreen(),));
                                  },
                                  child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: Colors.white,
                                      child: SvgPicture.asset(
                                        'assets/images/notification.svg',
                                        color:const Color.fromRGBO(152, 152, 152, 1),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 15,
                      right: 15,
                      bottom: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder:(context) => const ShipmentListScreen(),));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(250, 250, 250, 1),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        SvgPicture.asset(
                                          'assets/images/shipment.svg',
                                          height: 30,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'My Shipment',
                                          style: GoogleFonts.workSans(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TrackCourierListScreen()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(250, 250, 250, 1),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        SvgPicture.asset(
                                          'assets/images/track.svg',
                                          height: 30,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Track Courier',
                                          style: GoogleFonts.workSans(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'Recent Orders',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child:  ListView.builder(
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShipmentDetails()));
                                  },
                                  child: Container(
                                    // height: 100,width: double.infinity,
                                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(250, 250, 250, 1),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow:  [
                                        BoxShadow(
                                          color: const Color.fromRGBO(0, 0, 0, 0.1).withOpacity(0.1),
                                          blurRadius: 5,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child:Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(255, 250, 230, 1),
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Text('Tracking ID : 1234567890', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(51, 51, 51, 1)),),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text('Destination', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w400,color: const Color.fromRGBO(108, 117, 125, 1)),),
                                                  ),
                                                  const SizedBox(height: 6,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text('Status', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w400,color: const Color.fromRGBO(108, 117, 125, 1)),),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text('Received On', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w400,color: const Color.fromRGBO(108, 117, 125, 1)),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 0),
                                                    child: SizedBox(
                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                        child: Text('ELM Street, Spring ', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(51, 51, 51, 1)),overflow: TextOverflow.ellipsis,)),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 0),
                                                    child: Text('Pending', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(51, 51, 51, 1)),),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Text('06th June', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(51, 51, 51, 1)),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.only(right: 0),
                                                      child: TextButton(
                                                        onPressed: (){},
                                                        child: Text('', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(255, 0, 0, 1)),),
                                                      )
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Padding(
                                                      padding: const EdgeInsets.only(right: 0),
                                                      child: CircleAvatar(
                                                        radius: 19,
                                                        backgroundColor: const Color.fromRGBO(254, 205, 4, 1),
                                                        child:SvgPicture.asset('assets/images/arrow.svg',color: Colors.white,),
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

}
