import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_strings.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppStrings.subSectionPrefix,
                style: TextStyle(
                  fontSize: isDesktop ? 28 : 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                AppStrings.techStackTitle,
                style: TextStyle(
                  fontSize: isDesktop ? 28 : 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              AppStrings.techStackDescription,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 34),
          ...AppStrings.techStackCategories.entries
              .toList()
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final category = entry.value;
                return _buildCategory(
                      title: category.key,
                      items: category.value,
                    )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 90 * index),
                      duration: 520.ms,
                    )
                    .slideY(begin: 0.08, duration: 520.ms);
              }),
        ],
      ),
    );
  }

  Widget _buildCategory({required String title, required List<String> items}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items
                .map(
                  (item) => _buildTechCard(
                    item,
                    _iconForTech(item),
                    _colorForTech(item),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }

  Widget _buildTechCard(String name, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForTech(String name) {
    switch (name) {
      case 'Flutter':
        return Icons.flutter_dash;
      case 'React Native':
        return Icons.code_rounded;
      case 'Android Native':
      case 'Android':
        return Icons.android_rounded;
      case 'Dart':
      case 'TypeScript':
      case 'Java':
      case 'Kotlin':
        return Icons.data_object_rounded;
      case 'Clean Architecture':
      case 'MVVM':
      case 'MVC':
        return Icons.account_tree_rounded;
      case 'BLoC':
      case 'Riverpod':
      case 'Redux':
        return Icons.hub_rounded;
      case 'REST':
      case 'Dio':
      case 'Retrofit':
        return Icons.api_rounded;
      case 'Supabase':
      case 'Firebase':
        return Icons.storage_rounded;
      case 'Hive':
      case 'Room':
      case 'SharedPreferences':
      case 'MMKV':
        return Icons.inventory_2_rounded;
      case 'Git':
      case 'GitHub':
        return Icons.commit_rounded;
      case 'Copilot':
      case 'Cursor':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.code;
    }
  }

  Color _colorForTech(String name) {
    switch (name) {
      case 'Flutter':
        return const Color(0xFF02569B);
      case 'React Native':
        return const Color(0xFF61DAFB);
      case 'Android Native':
      case 'Android':
        return const Color(0xFF3DDC84);
      case 'Dart':
        return const Color(0xFF0175C2);
      case 'Kotlin':
        return const Color(0xFF7F52FF);
      case 'Java':
        return const Color(0xFFB07219);
      case 'TypeScript':
        return const Color(0xFF3178C6);
      case 'Supabase':
        return const Color(0xFF3ECF8E);
      case 'Firebase':
        return const Color(0xFFFFA000);
      case 'Git':
      case 'GitHub':
        return const Color(0xFFF05032);
      default:
        return const Color(0xFF4B5563);
    }
  }
}
