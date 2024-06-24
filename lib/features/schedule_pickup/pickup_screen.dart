import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/features/schedule_pickup/receiver_screen.dart';
import 'package:logmax/features/schedule_pickup/search_location_screen.dart';


import '../../../core/colors.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  double? currentLatitude;
  double? currentLongitude;
  String? currentAddress;
  bool isLoading = false;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _doorNoController = TextEditingController();
  final TextEditingController _floorNOController = TextEditingController();
  int selectedContainerIndex = -1; // Initialize with -1 to indicate no selection
  List<String> weightCategories = ['1-5 KG', '6-10 KG', '11-15 KG', '16-20 KG'];
  @override
  void initState() {
    super.initState();
  }

  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // Handle permission denied
      setState(() {
        isLoading = false;
      });
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark placemark = placemarks.first;

      setState(() {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
        currentAddress = "${placemark.name}, ${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
        _addressController.text = currentAddress!;
        print("Latitude: $currentLatitude, Longitude: $currentLongitude");
        print("Address: $currentAddress");
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false; // Set loading indicator to false in case of error
      });
    }
  }
  final List<String> countries = [
    'Electronics',
    'Medicines',
    'Groceries',
    'Books & Stationary',
    'Sports Equipments',
    'Others'
  ];
  String? selectedCountry;
  DateTime preBackPress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Schedule Pickup",
            style: GoogleFonts.workSans(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Pickup Location",
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
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: _getLocationPermission,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.my_location, color: Color.fromRGBO(255, 87, 51, 1), size: 20),
                      const SizedBox(width: 10),
                      Text(
                        'Use your Current Location',
                        style: GoogleFonts.workSans(
                          color: const Color.fromRGBO(255, 87, 51, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical:0),
                child: Text(
                  "Sender Details",
                  style: GoogleFonts.workSans(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
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
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromRGBO(152, 152, 152, 1)),
                ),
                child: DropdownButton<String>(
                  underline: Container(),
                  value: selectedCountry,
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  borderRadius: BorderRadius.circular(25),
                  dropdownColor: const Color.fromRGBO(236, 237, 243, 1),
                  hint: Text('Package Type', style:GoogleFonts.workSans(fontSize: 14, fontWeight: FontWeight.w500, color: const Color.fromRGBO(152, 152, 152, 1),),),
                  icon: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.keyboard_arrow_down)),
                  isExpanded: true,
                  items: countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCountry = newValue;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  "Package Weight",
                  style: GoogleFonts.workSans(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(weightCategories.length, (index) {
                    bool isSelected = selectedContainerIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedContainerIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color.fromRGBO(255, 243, 242, 1)
                              : const Color.fromRGBO(237, 237, 237, 1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromRGBO(152, 152, 152, 1)
                                .withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/product.svg',
                              color: isSelected
                                  ? appColor
                                  : const Color.fromRGBO(152, 152, 152, 1),
                            ),
                            Text(
                              weightCategories[index], // Use weight category for each container
                              style: GoogleFonts.workSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(152, 152, 152, 1),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                // hack textfield height
                padding: const EdgeInsets.only(bottom: 0),
                child:  TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Special Instruction!",
                    hintStyle: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(152, 152, 152, 1),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReceiverGetScreen()));
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                    child: Text('Next',style: GoogleFonts.workSans(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
