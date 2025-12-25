import 'package:flutter/material.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:e_commerce/utils/constant/colors.dart';

class ZChoiceChip extends StatelessWidget {
  const ZChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final Color? color = ZHelperFunctions.getColor(text);
    final bool isColorChip = color != null;

    // ================= COLOR CHIP =================
    if (isColorChip) {
      return GestureDetector(
        onTap: onSelected == null ? null : () => onSelected!(true),
        child: Container(
          margin: const EdgeInsets.only(
            right: 12,   // ✅ horizontal spacing
            bottom: 12,  // ✅ vertical spacing
          ),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected
                  ? ZColors.primaryColor
                  : Colors.grey.shade400,
              width: selected ? 3 : 1,
            ),
          ),
          child: selected
              ? const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
          )
              : null,
        ),
      );
    }

    // ================= TEXT CHIP =================
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: ChoiceChip(
        label: Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(
          color: selected ? ZColors.white : null,
        ),
      ),
    );
  }
}
