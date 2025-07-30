import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/app/modules/signup/controllers/signup_controller.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_dropdown.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_snack_bar.dart';

class EditProfileView extends StatefulWidget {
  final String? initialName;
  final String? initialGender;
  final String? initialLocation;
  final int? initialAge;
  final String? initialCategory;
  final String? initialPetInfo;
  final String? initialOwnerName;
  final String? initialOwnerRelationshipStatus;
  final String? initialOwnerGender;

  const EditProfileView({
    super.key,
    this.initialName,
    this.initialGender,
    this.initialLocation,
    this.initialAge,
    this.initialCategory,
    this.initialPetInfo,
    this.initialOwnerName,
    this.initialOwnerRelationshipStatus,
    this.initialOwnerGender,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController controller = Get.find<ProfileController>();
  final SignupController _signupController = Get.put(SignupController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController petInfoController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  String? selectedCategory;
  String? selectedOwnerRelationshipStatus;
  String? selectedOwnerGender;
  String? selectedGender;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.initialName ?? '';
    locationController.text = widget.initialLocation ?? '';
    ageController.text = widget.initialAge?.toString() ?? '';
    petInfoController.text = widget.initialPetInfo ?? '';
    ownerNameController.text = widget.initialOwnerName ?? '';
    selectedCategory = widget.initialCategory;
    selectedOwnerRelationshipStatus = widget.initialOwnerRelationshipStatus;
    selectedOwnerGender = widget.initialOwnerGender;
    selectedGender = widget.initialGender;

    if (_signupController.categories.isEmpty) {
      _signupController.fetchCategories();
    }
  }

  Future<void> pickImage(ImageSource source, String type) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          if (type == 'image') {
            controller.selectedImage.value = pickedFile;
            log('Profile image selected: ${pickedFile.path}');
          } else if (type == 'cover_image') {
            controller.coverImage.value = pickedFile;
            log('Cover image selected: ${pickedFile.path}');
          } else if (type == 'owner_image') {
            controller.ownerImage.value = pickedFile;
            log('Owner image selected: ${pickedFile.path}');
          }
        });
      } else {
        log('No image selected for type: $type');
      }
    } catch (e) {
      log('Error picking image: $e');
      kSnackBar(message: 'Error selecting image: $e', bgColor: AppColors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Edit Profile'),
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
      body: Obx(() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover photo and profile picture
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: controller.coverImage.value != null
                            ? FileImage(File(controller.coverImage.value!.path))
                            : controller.profileData.value?.data?.coverImage != null
                            ? NetworkImage(controller.profileData.value!.data!.coverImage!)
                            : AssetImage(AppImages.groupOfDogs) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => pickImage(ImageSource.gallery, 'cover_image'),
                      child: Container(
                        height: 30,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.black,
                        ),
                        child: Image.asset(
                          AppImages.media,
                          scale: 4,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: 16,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.selectedImage.value != null
                              ? FileImage(File(controller.selectedImage.value!.path))
                              : controller.profileData.value?.data?.image != null
                              ? NetworkImage(controller.profileData.value!.data!.image!)
                              : AssetImage(AppImages.profileImage) as ImageProvider,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => pickImage(ImageSource.gallery, 'image'),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.black,
                              child: Icon(Icons.add, color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sh60,
              // Remove Image option
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (controller.selectedImage.value != null || controller.coverImage.value != null) {
                        controller.selectedImage.value = null;
                        controller.coverImage.value = null;
                        kSnackBar(message: 'Images cleared', bgColor: AppColors.green);
                      } else {
                        kSnackBar(message: 'No images to clear', bgColor: AppColors.orange);
                      }
                    });
                  },
                  child: Text(
                    'Remove Image',
                    style: h5,
                  ),
                ),
              ),
              sh24,
              // Pet Name
              Text('Pet Name', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: nameController,
                containerColor: AppColors.white,
                hintText: 'Enter your pet name',
              ),
              sh16,
              // Location
              Text('Location', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: locationController,
                containerColor: AppColors.white,
                hintText: 'Enter your pet location',
              ),
              sh16,
              // Gender
              Text('Gender', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomDropdown(
                value: selectedGender,
                items: ['Male', 'Female'],
                hintText: 'Select your pet gender',
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                  log('Selected gender: $value');
                },
              ),
              sh16,
              // Age
              Text('Age', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: ageController,
                containerColor: AppColors.white,
                hintText: 'Enter your pet age',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              sh16,
              // Category
              Text('Category', style: h2.copyWith(fontSize: 18)),
              sh8,
              Obx(() {
                if (_signupController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_signupController.categories.isEmpty) {
                  return const Text(
                    'No categories available',
                    style: TextStyle(color: AppColors.red),
                  );
                }
                return CustomDropdown(
                  value: selectedCategory,
                  items: _signupController.categories.map((category) => category.name!).toList(),
                  hintText: 'Select your pet category',
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
              Text('Pet info', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: petInfoController,
                height: 150,
                containerColor: AppColors.white,
                hintText: 'Write here...',
              ),
              sh16,
              // Pet Owner Profile Picture
              Text('Pet Owner Profile Picture', style: h2.copyWith(fontSize: 18)),
              sh12,
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.white,
                      backgroundImage: controller.ownerImage.value != null
                          ? FileImage(File(controller.ownerImage.value!.path))
                          : controller.profileData.value?.data?.ownerImage != null
                          ? NetworkImage(controller.profileData.value!.data!.ownerImage!)
                          : null,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => pickImage(ImageSource.gallery, 'owner_image'),
                      child: Image.asset(
                        AppImages.edit,
                        scale: 4,
                      ),
                    ),
                  ),
                ],
              ),
              sh16,
              // Pet Owner Name
              Text('Pet Owner Name', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomTextField(
                controller: ownerNameController,
                containerColor: AppColors.white,
                hintText: 'Owner name',
              ),
              sh16,
              // Relationship
              Text('Relationship', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomDropdown(
                value: selectedOwnerRelationshipStatus,
                items: ['Single', 'Married'],
                hintText: 'Select your relationship status',
                onChanged: (value) {
                  setState(() {
                    selectedOwnerRelationshipStatus = value;
                  });
                  log('Selected relationship: $value');
                },
              ),
              sh16,
              // Gender
              Text('Gender', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomDropdown(
                value: selectedOwnerGender,
                items: ['Male', 'Female'],
                hintText: 'Select your gender',
                onChanged: (value) {
                  setState(() {
                    selectedOwnerGender = value;
                  });
                  log('Selected gender: $value');
                },
              ),
              sh30,
              CustomButton(
                text: 'Save',
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      locationController.text.isEmpty ||
                      ageController.text.isEmpty ||
                      selectedCategory == null ||
                      petInfoController.text.isEmpty ||
                      ownerNameController.text.isEmpty ||
                      selectedOwnerRelationshipStatus == null ||
                      selectedOwnerGender == null ||
                      selectedGender == null) {
                    kSnackBar(
                      message: 'All fields are required',
                      bgColor: AppColors.orange,
                    );
                    return;
                  }

                  int? age = int.tryParse(ageController.text);
                  if (age == null || age <= 0) {
                    kSnackBar(
                      message: 'Please enter a valid age',
                      bgColor: AppColors.orange,
                    );
                    return;
                  }

                  controller.updateProfile(
                    name: nameController.text,
                    gender: selectedGender!.toLowerCase(),
                    location: locationController.text,
                    age: age,
                    category: selectedCategory!,
                    petInfo: petInfoController.text,
                    ownerName: ownerNameController.text,
                    ownerRelationshipStatus: selectedOwnerRelationshipStatus!.toLowerCase(),
                    ownerGender: selectedOwnerGender!.toLowerCase(),
                    selectedImage: controller.selectedImage.value,
                    ownerImage: controller.ownerImage.value,
                    coverImage: controller.coverImage.value,
                  );

                },
              ),
              sh30,
            ],
          ),
        ),
      )),
    );
  }
}