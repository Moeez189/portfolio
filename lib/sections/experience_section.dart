import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.experienceTitle,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          ...AppStrings.experienceItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(item),
            ),
          ),
        ],
      ),
    );
  }
}
