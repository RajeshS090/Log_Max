import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/features/home/myshipment/shipment_details_screen.dart';

import '../../../core/colors.dart';

class ShipmentListScreen extends StatefulWidget {
  const ShipmentListScreen({super.key});

  @override
  State<ShipmentListScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<ShipmentListScreen> {
  bool _isFirstContainerSelected = true;

  void _toggleSelection(bool isFirstContainer) {
    setState(() {
      _isFirstContainerSelected = isFirstContainer;
    });
  }
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
            title: const Text(
              "My Shipment List",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 10,),
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
                              ? appColor
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Active Shipment',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _isFirstContainerSelected
                                  ? Colors.white
                                  : appColor,
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
                              ? appColor
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Past Shipment',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: !_isFirstContainerSelected
                                  ? Colors.white
                                  : appColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShipmentDetails()));
                      },
                      child: Container(
                        // height: 100,width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 239, 239, 1),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Text('Tracking ID : 1234567890', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(51, 51, 51, 1)),),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: TextButton(
                                      onPressed: (){},
                                      child: Text('Cancel', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(255, 0, 0, 1)),),
                                    )
                                ),
                              ],
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
                                            width: MediaQuery.of(context).size.width * 0.45,
                                            child: Text('ELM Street, Spring ', style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: const Color.fromRGBO(51, 51, 51, 1)),overflow: TextOverflow.ellipsis,)),
                                      ),
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
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
                                      const SizedBox(height: 5,),
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              radius: 19,
                                              backgroundColor: const Color.fromRGBO(254, 205, 4, 1),
                                              child:SvgPicture.asset('assets/images/arrow.svg',color: Colors.white,),
                                            ),
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
        )
    );
  }
}
