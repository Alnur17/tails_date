import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/app_text_style/styles.dart';

class CategoryWidget extends StatelessWidget {
  final String name;
  final String backImage;

  const CategoryWidget({
    super.key,
    required this.name,
    required this.backImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,top: 8,bottom: 16),
      child: Container(
        height: 140,
        width: Get.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(backImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black26,
          ),
          child: Center(
            child: Text(
              name,
              style: h1.copyWith(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
