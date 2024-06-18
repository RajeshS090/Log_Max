import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackViewScreen extends StatefulWidget {
  const TrackViewScreen({super.key});

  @override
  State<TrackViewScreen> createState() => _TrackViewScreenState();
}

class _TrackViewScreenState extends State<TrackViewScreen> {
  // MapBoxNavigationViewController? _controller;
  String? _instruction;
  bool _isMultipleStop = false;
  double? _distanceRemaining, _durationRemaining;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  bool _arrived = false;
  // late MapBoxOptions _navigationOption;

  // Future<void> initialize() async {
  //   if (!mounted) return;
  //   _navigationOption = MapBoxNavigation.instance.getDefaultOptions();
  //   _navigationOption.initialLatitude = 37.7749;
  //   _navigationOption.initialLongitude = -122.4194;
  //   _navigationOption.mode = MapBoxNavigationMode.driving;
  //   MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);
  // }


  // @override
  // void initState() {
  //   initialize();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _controller?.dispose();
  //   super.dispose();
  // }

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
              "Tracking ID : #5122333",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          // body: Column(
          //   children: [
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 1,
          //       child: Container(
          //         color: Colors.grey[100],
          //         child: MapBoxNavigationView(
          //           options: _navigationOption,
          //           onRouteEvent: _onRouteEvent,
          //           onCreated: (MapBoxNavigationViewController controller) async {
          //             _controller = controller;
          //             controller.initialize();
          //           },
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        )
    );
  }
  // Future<void> _onRouteEvent(e) async {
  //
  //   _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
  //   _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();
  //
  //   switch (e.eventType) {
  //     case MapBoxEvent.progress_change:
  //       var progressEvent = e.data as RouteProgressEvent;
  //       _arrived = progressEvent.arrived!;
  //       if (progressEvent.currentStepInstruction != null) {
  //         _instruction = progressEvent.currentStepInstruction;
  //       }
  //       break;
  //     case MapBoxEvent.route_building:
  //     case MapBoxEvent.route_built:
  //       _routeBuilt = true;
  //       break;
  //     case MapBoxEvent.route_build_failed:
  //       _routeBuilt = false;
  //       break;
  //     case MapBoxEvent.navigation_running:
  //       _isNavigating = true;
  //       break;
  //     case MapBoxEvent.on_arrival:
  //       _arrived = true;
  //       if (!_isMultipleStop) {
  //         await Future.delayed(const Duration(seconds: 3));
  //         await _controller?.finishNavigation();
  //       } else {}
  //       break;
  //     case MapBoxEvent.navigation_finished:
  //     case MapBoxEvent.navigation_cancelled:
  //       _routeBuilt = false;
  //       _isNavigating = false;
  //       break;
  //     default:
  //       break;
  //   }
  //   //refresh UI
  //   setState(() {});
  // }
}
