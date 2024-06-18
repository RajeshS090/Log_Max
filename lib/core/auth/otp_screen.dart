// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:otpless_flutter/otpless_flutter.dart';
//
// class OTPScreen extends StatefulWidget {
//   final String phoneNumber;
//   final String requestId;
//
//   OTPScreen({required this.phoneNumber, required this.requestId});
//
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   final _otplessFlutterPlugin = Otpless();
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _otplessFlutterPlugin.initHeadless("BQ700FOUQM2TL832QZ6M"); // Replace with your App ID
//     _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
//   }
//   void _verifyOTP() {
//     String otp = _otpController.text;
//     if (otp.isNotEmpty && otp.length == 6) {
//       print("Sending OTP for verification: $otp");
//       _verifyOTPWithOTPless(otp);
//     } else {
//       Fluttertoast.showToast(
//         msg: "Please enter a valid 6-digit OTP.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//       );
//     }
//   }
//
//   void _verifyOTPWithOTPless(String otp) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     Map<String, dynamic> arg = {
//       "phone": widget.phoneNumber,
//       "countryCode": "91",
//       "otp": otp,
//       "requestID": widget.requestId,
//     };
//
//     debugPrint("Sending verification request with args: $arg");
//
//     try {
//       _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
//     } catch (e) {
//       debugPrint("Error in startHeadless: $e");
//       print("Error in startHeadless😍😍😍😍: $e");
//       setState(() {
//         _isLoading = false;
//       });
//       Fluttertoast.showToast(
//         msg: "Error: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//       );
//     }
//   }
//
//   void onHeadlessResult(dynamic result) {
//     debugPrint("onHeadlessResult called with result: $result");
//     setState(() {
//       _isLoading = false;
//     });
//
//     if (result != null) {
//       int statusCode = result['statusCode'] ?? 0;
//       bool success = result['success'] ?? false;
//       String errorMessage = result['errorMessage'] ?? "Unknown error occurred";
//
//       debugPrint("Status Code: $statusCode");
//       debugPrint("Success: $success");
//       debugPrint("Error Message🤣🤣🤣: $errorMessage");
//
//       if (statusCode == 200 && success) {
//         final response = result['response'];
//         if (response != null && response['verification'] == "COMPLETED") {
//           navigateToNextScreen();
//         } else {
//           String errorMsg = response != null
//               ? "Verification status: ${response['verification'] ?? 'Unknown'}"
//               : "Response data is missing";
//           Fluttertoast.showToast(
//             msg: errorMsg,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//           );
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: "Error ($statusCode): $errorMessage",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.CENTER,
//         );
//       }
//     } else {
//       Fluttertoast.showToast(
//         msg: "No response from server",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//       );
//     }
//   }
//
//
//   void navigateToNextScreen() {
//     Fluttertoast.showToast(
//       msg: "OTP Verified Successfully",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//     );
//     // TODO: Implement navigation logic to the next screen or perform required actions
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter OTP'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Enter the OTP sent to ${widget.phoneNumber}'),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _otpController,
//                 keyboardType: TextInputType.number,
//                 maxLength: 6,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter OTP',
//                   counterText: '',
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _verifyOTP,
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text('Verify OTP'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
