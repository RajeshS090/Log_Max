import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  DateTime preBackPress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            DateTime now = DateTime.now();
            if (now.difference(preBackPress) > const Duration(seconds: 2)) {
              preBackPress = now;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  content: Text('Press back again to exit'),
                ),
              );
            }
            else {
              await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
            return false;
          },
          child: const Scaffold(
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
            body: Center(
              child: Text('Wallet Screen'),
            ),
          ),
        )
    );
  }
}
