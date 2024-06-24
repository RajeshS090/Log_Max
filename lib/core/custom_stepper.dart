import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStepper extends StatelessWidget {
  final List<String> steps;
  final int currentStep;
  final double radius;

  const CustomStepper({
    Key? key,
    required this.steps,
    required this.currentStep,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Column(
            children: [
              Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  color: i <= currentStep ? Colors.red : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (i + 1).toString(),
                    style: const TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5),
                child: Text(
                  steps[i],
                  style: GoogleFonts.workSans(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 29),
                  height: 1,
                  color: i < currentStep ? Colors.red : Colors.grey,
                ),
              ),
            ),
        ],
      ],
    );
  }
}