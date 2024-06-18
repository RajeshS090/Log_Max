import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int _selectedValue = 1;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value!;
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
              "Check Out",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ElevatedButton(onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckOutScreen()));
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text('Pay Now',style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
            ),
          ),
          body:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     Expanded(
                       flex: 1,
                       child: Column(
                         children: [
                           const Padding(
                             padding: EdgeInsets.symmetric(horizontal: 20),
                             child: Icon(Icons.location_on, color: Colors.redAccent, size: 30,),
                           ),
                           Container(height: 60,width: 1,color:const Color.fromRGBO(255, 87, 51, 0.25),),
                           const Padding(
                             padding: EdgeInsets.symmetric(horizontal: 20),
            
                             child: Icon(Icons.location_on, color: Colors.green, size: 30,),
                           ),
                         ],
                       ),
                     ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Pickup Location',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:14,fontWeight: FontWeight.w500),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Pickup Location Pickup',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w500),),
                          ),
                          const SizedBox(height: 50,width: 1,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Pickup Location',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:14,fontWeight: FontWeight.w500),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Pickup Location',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                    ),
                     Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: (){},
                              child: const CircleAvatar(
                                backgroundColor:Color.fromRGBO(255, 255, 255, 1),
                                  child: Icon(Icons.edit_location_alt_sharp, color: Colors.redAccent, size: 30,)),
                            ),
                          ),
                          const SizedBox(height: 64,width: 1,),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(Icons.location_on, color: Colors.transparent, size: 30,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Delivery on 06th, June at 5 pm',style: GoogleFonts.workSans(color: const Color.fromRGBO(152, 152, 152, 1),fontSize:16,fontWeight: FontWeight.w500),),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Payment Method',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:18,fontWeight: FontWeight.w500),),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    setState(() {
                      _selectedValue = 1;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      'Cash on delivery',
                      style: GoogleFonts.workSans(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Radio(
                      value: 1,
                      groupValue: _selectedValue,
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      _selectedValue = 2;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      'Online Payment',
                      style: GoogleFonts.workSans(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Radio(
                      value: 2,
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      groupValue: _selectedValue,
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Payment Details',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:18,fontWeight: FontWeight.w500),),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text('Package Weight',style: GoogleFonts.workSans(color: const Color.fromRGBO(152, 152, 152, 1),fontSize:16,fontWeight: FontWeight.w500),),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text('5 KG-10 KG',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:16,fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text('Delivery Fee',style: GoogleFonts.workSans(color: const Color.fromRGBO(152, 152, 152, 1),fontSize:16,fontWeight: FontWeight.w500),),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text('₹250',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:16,fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: Colors.black,
                    dashGradient: const [Colors.red, Colors.blue],
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapGradient: const [Colors.red, Colors.blue],
                    dashGapRadius: 0.0,
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text('Total',style: GoogleFonts.workSans(color: const Color.fromRGBO(152, 152, 152, 1),fontSize:16,fontWeight: FontWeight.w500),),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text('₹450',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:16,fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
