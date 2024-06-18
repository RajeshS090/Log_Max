import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
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
              "Add Address",
              style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 1),
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
              child: Text('Save Address',style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    // controller: _floorNOController,
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    // controller: _floorNOController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Street',
                      hintStyle: GoogleFonts.workSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(152, 152, 152, 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    // controller: _floorNOController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'State',
                      hintStyle: GoogleFonts.workSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(152, 152, 152, 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    // controller: _floorNOController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'City',
                      hintStyle: GoogleFonts.workSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(152, 152, 152, 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    // controller: _floorNOController,
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
        )
    );
  }
}
