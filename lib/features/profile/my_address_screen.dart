import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_address_screen.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child:Scaffold(
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
              "My Address",
              style: GoogleFonts.workSans(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Text('Home',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:18,fontWeight: FontWeight.w500),),
              // ),
              const SizedBox(height: 0,),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 4,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Akash',style: GoogleFonts.workSans(color: const Color.fromRGBO(0, 0, 0, 1),fontSize:18,fontWeight: FontWeight.w500),),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color.fromRGBO(0, 0, 0, 1), size: 20,),
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text('Delete',style: GoogleFonts.workSans(color: const Color.fromRGBO(255, 0, 0, 1),fontSize:16,fontWeight: FontWeight.w500),),
                                  Container(height: 1,width: 50,color:const Color.fromRGBO(255, 0, 0, 1) ,)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                             width: 300,
                              child: Text('1234 Elm Street, Springfield, IL 62704',style: GoogleFonts.workSans(color: const Color.fromRGBO(108, 117, 125, 1),fontSize:16,fontWeight: FontWeight.w500),)),
                        ),
                      ],
                    );
                  }
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAddress()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Color.fromRGBO(255, 87, 51, 1), size: 20,),
                    const SizedBox(width:4,),
                    Text('Add new address',style: GoogleFonts.workSans(color: const Color.fromRGBO(255, 87, 51, 1),fontSize:16,fontWeight: FontWeight.w500),),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
