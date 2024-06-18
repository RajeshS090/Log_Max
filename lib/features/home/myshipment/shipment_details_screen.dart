import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:order_tracker_zen/order_tracker_zen.dart';

import '../../../core/colors.dart';

class ShipmentDetails extends StatefulWidget {
  const ShipmentDetails({super.key});

  @override
  State<ShipmentDetails> createState() => _ShipmentDetailsState();
}

class _ShipmentDetailsState extends State<ShipmentDetails> {
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
              "Shipment details",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Tracking Number :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                      flex: 1,
                        child:Text('123456789',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Pickup Date  :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child:Text('06-06-2024',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Status :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child:Text('Pending',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Package Type  :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child:Text('Electronics',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Weight  :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child:Text('10 KG',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Pickup Address :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child:Text('ELM Street, Spring',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Delivery Address :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child:Text('ELM Street, Spring',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row  (
                  children: [
                    Expanded(
                        flex: 1,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Special Instructions  :',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child:Text('Handle with Care',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:15,fontWeight: FontWeight.w500),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Order Summary',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize: 16,fontWeight: FontWeight.w500),),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AnotherStepper(
                    stepperList: stepperData,
                    stepperDirection: Axis.vertical,
                    activeIndex: 2,
                    activeBarColor: appColor,
                    iconWidth: 30, // Height that will be applied to all the stepper icons
                    iconHeight: 30, // Width that will be applied to all the stepper icons
                  )
                )
              ],
            ),
          ),
        )
    );
  }
  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Placed",
        ),
        subtitle: StepperText("06th, june , 02:00 PM"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration:  const BoxDecoration(
              color: Color.fromRGBO(255, 87, 51, 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          // child: const Icon(Icons.looks_one, color: Colors.white),
        )),
    StepperData(
        title: StepperText("Picked Up"),
        subtitle: StepperText("06th, june , 02:10 PM"),
        iconWidget: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 87, 51, 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          // child: const Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
        title: StepperText("On the way"),
        subtitle: StepperText("06th, june , 02:20 PM"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 87, 51, 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          // child: const Icon(Icons.looks_3, color: Colors.white),
        )),
    StepperData(
      title: StepperText("Delivered",
          textStyle: const TextStyle(
            color: Colors.grey,
          )),
    ),
  ];
}
