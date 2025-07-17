import 'package:flutter/material.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String> onChanged;
  final String? value; // Added to support initial value

  const CustomDropdown({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Set initial value if provided
    if (widget.value != null && widget.items.contains(widget.value)) {
      selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDropdownDialog(context);
      },
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue ?? widget.hintText,
              style: selectedValue == null
                  ? h4.copyWith(color: AppColors.grey)
                  : h4.copyWith(color: AppColors.black),
            ),
            Image.asset(AppImages.arrowDown, scale: 4),
          ],
        ),
      ),
    );
  }

  void _showDropdownDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return ListTile(
              title: Text(item, style: h3.copyWith(color: AppColors.white)),
              onTap: () {
                setState(() {
                  selectedValue = item;
                });
                widget.onChanged(item); // Trigger callback with selected value
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}