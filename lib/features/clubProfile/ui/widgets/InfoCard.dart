import 'package:akalpit/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ModernInfoCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final bool isTextValue;

  const ModernInfoCard({
    required this.value,
    required this.label,
    required this.icon,
    this.isTextValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            /// ICON (SUBTLE)
            Icon(
              icon,
              size: 18,
              color: Colors.white38,
            ),

            const SizedBox(height: 10),

            /// MAIN VALUE
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTextValue ? 13 : 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 4),

            /// LABEL
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
