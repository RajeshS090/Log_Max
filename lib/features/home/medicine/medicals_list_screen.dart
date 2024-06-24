import 'package:flutter/material.dart';

class MedicalsListScreen extends StatefulWidget {
  const MedicalsListScreen({super.key});

  @override
  State<MedicalsListScreen> createState() => _MedicalsListScreenState();
}

class _MedicalsListScreenState extends State<MedicalsListScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child:Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          body: Center(
            child: Text('Medicals List Screen'),
          ),
        )
    );
  }
}
