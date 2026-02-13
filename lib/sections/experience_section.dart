import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Experience",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Text("Code Upscale LLC – React Native Developer (2024–Present)"),
          SizedBox(height: 20),
          Text("Skynet Solutionz – Android Developer (2023–2024)"),
          SizedBox(height: 20),
          Text("EvolversTech – Android & React Native Developer"),
        ],
      ),
    );
  }
}
