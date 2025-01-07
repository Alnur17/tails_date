import 'package:flutter/material.dart';
import 'custom_textfield.dart';


class SearchFiled extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchFiled({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChange: onChanged,
      hintText: 'Search...',
      borderRadius: 30,
    );
  }
}
