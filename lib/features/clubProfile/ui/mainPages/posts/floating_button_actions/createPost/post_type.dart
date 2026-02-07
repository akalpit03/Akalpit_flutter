import 'package:flutter/material.dart';

class PostTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onChanged;

  const PostTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final types = ["Announcement", "Update", "Felicitation"];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 40, 37, 37),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: types.map((type) {
          final isSelected = selectedType == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(type),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromARGB(255, 224, 226, 228)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    type,
                    style: TextStyle(
                      color:
                          isSelected ? Colors.black : Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
