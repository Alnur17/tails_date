import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/controllers/other_pet_controller.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dropdown.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../signup/controllers/signup_controller.dart';
import '../controllers/profile_controller.dart';

class AddMorePetView extends StatefulWidget {
  const AddMorePetView({super.key});

  @override
  State<AddMorePetView> createState() => _AddMorePetViewState();
}

class _AddMorePetViewState extends State<AddMorePetView> {
  final OtherPetController otherPetController = Get.put(OtherPetController());
  final SignupController signupController = Get.put(SignupController());
  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController petInfoController = TextEditingController();
  String? selectedCategory;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (signupController.categories.isEmpty) {
        signupController.fetchCategories();
      }
      log('Layout is completed and ready for interaction');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Add More Pet'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Image',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              Obx(() {
                if (otherPetController.selectedImagePath.value.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await otherPetController.pickImageFromCamera();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.black),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.camera, scale: 4),
                                sw8,
                                Text('Use_Camera'.tr,
                                    style: h4, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sw16,
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await otherPetController.pickImageFromGallery();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.black),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.gallery, scale: 4),
                                sw8,
                                Text('Choose_From_Gallery'.tr,
                                    style: h4, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                          border: Border.all(color: AppColors.black),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(otherPetController.selectedImagePath.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            otherPetController.selectedImagePath.value = '';
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close,
                                color: AppColors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
              sh16,
              Text('Pet_Name'.tr, style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: nameController,
                containerColor: AppColors.white,
                hintText: 'Enter_Your_Pet_Name'.tr,
              ),
              sh16,
              Text('Gender'.tr, style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomDropdown(
                value: selectedGender,
                items: ['Male', 'Female'],
                hintText: 'Select_Your_Pet_Gender'.tr,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                  log('Selected gender: $value');
                },
              ),
              sh16,
              Text('Age'.tr, style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: ageController,
                containerColor: AppColors.white,
                hintText: 'Enter_Your_Pet_Age'.tr,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              sh16,
              // Category
              Text('Category'.tr, style: h2.copyWith(fontSize: 18)),
              sh8,
              Obx(() {
                if (signupController.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.black,
                  ));
                }
                if (signupController.categories.isEmpty) {
                  return Text(
                    'No_Categories_Available'.tr,
                    style: TextStyle(color: AppColors.red),
                  );
                }
                return CustomDropdown(
                  value: selectedCategory,
                  items: signupController.categories
                      .map((category) => category.name!)
                      .toList(),
                  hintText: 'Select_Your_Pet_Category'.tr,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                    log('Selected category: $value');
                  },
                );
              }),
              sh16,
              // Pet Info
              Text('Pet_Info'.tr, style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: petInfoController,
                height: 150,
                containerColor: AppColors.white,
                hintText: 'Write_Here'.tr,
              ),
              sh30,
              CustomButton(
                  text: 'Save'.tr,
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        ageController.text.isEmpty ||
                        selectedCategory == null ||
                        petInfoController.text.isEmpty ||
                        selectedGender == null) {
                      kSnackBar(
                        message: 'All_Fields_Are_Required'.tr,
                        bgColor: AppColors.orange,
                      );
                      return;
                    }

                    int? age = int.tryParse(ageController.text);
                    if (age == null || age <= 0) {
                      kSnackBar(
                        message: 'Please_Enter_A_Valid_Age'.tr,
                        bgColor: AppColors.orange,
                      );
                      return;
                    }
                    final categoryObj = signupController.categories.firstWhere(
                          (categoryItem) => categoryItem.name == selectedCategory,
                    );

                    final categoryId = categoryObj.id;

                    otherPetController.addMorePets(
                      name: nameController.text,
                      gender: selectedGender!.toLowerCase(),
                      age: age,
                      category: categoryId,
                      info: petInfoController.text,
                      image: otherPetController.selectedImagePath.value,
                      context: context,
                    );
                  }),
              sh30
            ],
          ),
        ),
      ),
    );
  }
}
