import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logmax/features/home/home_screen.dart';
import 'package:logmax/features/notification/notification_screen.dart';

import '../features/profile/profile_screen.dart';
import '../features/schedule_pickup/pickup_screen.dart';
import '../features/wallet/wallet.dart';

class BottomBar extends StatefulWidget {
  final int tabIndex;
  const BottomBar({super.key, required this.tabIndex});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int currentIndex;
  final List<Widget> _pages = [
    HomeScreen(onExit: () {}),
    const PickUpScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.tabIndex; // Set initial tab based on passed tabIndex
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        body: _pages[currentIndex],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: size.width * .155,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.2).withOpacity(.1),
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(50),
          ),
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: size.width * .014),
            itemBuilder: (context, index) {
              double svgHeight = size.width * .066;
              Color svgColor = const Color.fromRGBO(188, 188, 188, 1);
              Color textColor = const Color.fromRGBO(188, 188, 188, 1);
              // Increase height and set color for the Rectangle SVG
              if (index == 1) {
                svgHeight = size.width * .077;
                svgColor = Colors.red;
              } else {
                svgColor = index == currentIndex
                    ? const Color.fromRGBO(0, 0, 0, 1)
                    : const Color.fromRGBO(188, 188, 188, 1);
                textColor = index == currentIndex
                    ? const Color.fromRGBO(0, 0, 0, 1)
                    : const Color.fromRGBO(188, 188, 188, 1);
              }

              return InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      margin: EdgeInsets.only(
                        bottom: index == currentIndex ? 0 : size.width * .028,
                        right: size.width * .0422,
                        left: size.width * .0422,
                      ),
                      width: size.width * .212,
                      height: index == currentIndex ? size.width * .00 : 0,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 228, 222, 1),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          svgAssets[index],
                          width: svgHeight,
                          height: svgHeight,
                          color: svgColor,
                        ),
                        if (index == 1)
                          Icon(
                            Icons.add,
                            size: svgHeight / 1,
                            color: Colors.white,
                          ),
                      ],
                    ),
                    SizedBox(height: size.width * 0),
                    Text(
                      listOfTexts[index],
                      style: GoogleFonts.workSans(
                        fontSize: 12,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  final List<String> svgAssets = [
    "assets/images/home.svg",
    'assets/images/Rectangle.svg',
    'assets/images/profile.svg',
  ];
  final List<String> listOfTexts = [
    'Home',
    '',
    'Profile',
  ];
}
