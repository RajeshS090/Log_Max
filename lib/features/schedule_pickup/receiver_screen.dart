import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/features/schedule_pickup/search_location_screen.dart';

import '../../../core/colors.dart';
import 'check_out_screen.dart';

class ReceiverGetScreen extends StatefulWidget {
  const ReceiverGetScreen({super.key});

  @override
  State<ReceiverGetScreen> createState() => _ReceiverGetScreenState();
}

class _ReceiverGetScreenState extends State<ReceiverGetScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _doorNoController = TextEditingController();
  final TextEditingController _floorNOController = TextEditingController();
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
              "Receiver Details",
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckOutScreen()));
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text('Continue',style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Receiver Details",
                    style: GoogleFonts.workSans(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      // maxLines: 2,
                      onTap: () {
                        if(_addressController.text.isEmpty){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const SearchLocation()));
                        }
                      },
                      controller: _addressController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Address',
                        hintStyle: GoogleFonts.workSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(152, 152, 152, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _nameController,
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
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _mobileController,
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
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _doorNoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Door No',
                        hintStyle: GoogleFonts.workSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(152, 152, 152, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _floorNOController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Floor No',
                        hintStyle: GoogleFonts.workSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(152, 152, 152, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
