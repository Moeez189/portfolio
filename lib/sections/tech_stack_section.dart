import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          // Section Title
          Row(
            children: [
              Text(
                '### ',
                style: TextStyle(
                  fontSize: isDesktop ? 28 : 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                'My tech stack',
                style: TextStyle(
                  fontSize: isDesktop ? 28 : 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: 12),

          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Building with: Flutter, React Native, Node.js, and more — tools that power modern, scalable solutions.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: 40),

          // Tech Icons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildTechIcon(
                'Flutter',
                Icons.flutter_dash,
                const Color(0xFF02569B),
              ),
              _buildTechIcon('React', Icons.code, const Color(0xFF61DAFB)),
              _buildTechIcon(
                'TypeScript',
                Icons.code_rounded,
                const Color(0xFF3178C6),
              ),
              _buildTechIcon(
                'Firebase',
                Icons.local_fire_department,
                const Color(0xFFFFA000),
              ),
              _buildTechIcon(
                'Supabase',
                Icons.storage_rounded,
                const Color(0xFF3ECF8E),
              ),
              _buildTechIcon(
                'Node.js',
                Icons.developer_mode,
                const Color(0xFF339933),
              ),
              _buildTechIcon('Git', Icons.merge_type, const Color(0xFFF05032)),
              _buildTechIcon(
                'VS Code',
                Icons.edit_note,
                const Color(0xFF007ACC),
              ),
              _buildTechIcon('Android', Icons.android, const Color(0xFF3DDC84)),
              _buildTechIcon('iOS', Icons.apple, const Color(0xFF000000)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechIcon(String name, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9));
  }
}
