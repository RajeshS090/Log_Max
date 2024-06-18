import 'package:flutter/material.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
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
           title: const Text(
             "Search Location",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search Location',

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08)
                      )
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(255, 255, 255, 1),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(138, 43, 226, 1)
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
