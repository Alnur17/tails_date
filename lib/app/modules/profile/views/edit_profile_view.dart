// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:tails_date/common/widgets/custom_button.dart';
// import 'package:tails_date/common/widgets/custom_dropdown.dart';
// import 'package:tails_date/common/widgets/custom_textfield.dart';
//
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
//
// class EditProfileView extends GetView {
//   const EditProfileView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Edit Profile'),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(
//             AppImages.back,
//             scale: 4,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Cover photo and profile picture
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(AppImages.groupOfDogs),
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 12,
//                     right: 12,
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         height: 30,
//                         decoration: ShapeDecoration(
//                             shape: CircleBorder(), color: Colors.black),
//                         child: Image.asset(
//                           AppImages.media,
//                           scale: 4,
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: -50,
//                     left: 16,
//                     //left: MediaQuery.of(context).size.width / 2 - 66,
//                     child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: NetworkImage(AppImages.profileImage),
//                         child: Align(
//                           alignment: Alignment.topRight,
//                           child: CircleAvatar(
//                             radius: 15,
//                             backgroundColor: AppColors.black,
//                             child: GestureDetector(
//                               onTap: () {
//                                 log('Add icon tapped');
//                               },
//                               child: Icon(Icons.add, color: AppColors.white),
//                             ),
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//               sh60,
//               // Profile info
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   'Remove Image',
//                   style: h5,
//                 ),
//               ),
//               sh24,
//               Text(
//                 'Pet Name',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomTextField(
//                 containerColor: AppColors.white,
//                 hintText: 'Enter your pet name',
//               ),
//               sh16,
//               Text(
//                 'Location',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomTextField(
//                 containerColor: AppColors.white,
//                 hintText: 'Enter your pet location',
//               ),
//               sh16,
//               Text(
//                 'Gender',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomDropdown(
//                 items: ['Male', 'Female'],
//                 hintText: 'Select your pet gender',
//                 onChanged: (value) {
//                   log('Selected value: $value');
//                 },
//               ),
//               sh16,
//               Text(
//                 'Age',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomTextField(
//                 containerColor: AppColors.white,
//                 hintText: 'Enter your pet age',
//               ),
//               sh16,
//               Text(
//                 'Category',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomDropdown(
//                 items: [
//                   'Cat',
//                   'Dog',
//                   'Bird',
//                   'Exotic Animal',
//                   'Farm Animal',
//                 ],
//                 hintText: 'Select your pet category',
//                 onChanged: (value) {
//                   log('Selected value: $value');
//                 },
//               ),
//               sh16,
//               Text(
//                 'Pet info',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomTextField(
//                 height: 150,
//                 containerColor: AppColors.white,
//                 hintText: 'Write here...',
//               ),
//               sh16,
//               Text(
//                 'Pet Owner Profile Picture',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh12,
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundColor: AppColors.white,
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     child: Image.asset(
//                       AppImages.edit,
//                       scale: 4,
//                     ),
//                   ),
//                 ],
//               ),
//
//               sh16,
//               Text(
//                 'Pet Owner Name',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomTextField(
//                 containerColor: AppColors.white,
//                 hintText: 'Owner name',
//               ),
//               sh16,
//               Text(
//                 'Relationship',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomDropdown(
//                 items: ['Single', 'Married'],
//                 hintText: 'Select your relationship status',
//                 onChanged: (value) {
//                   log('Selected value: $value');
//                 },
//               ),
//               sh16,
//               Text(
//                 'Gender',
//                 style: h2.copyWith(fontSize: 18),
//               ),
//               sh8,
//               CustomDropdown(
//                 items: ['Male', 'Female'],
//                 hintText: 'Select your gender',
//                 onChanged: (value) {
//                   log('Selected value: $value');
//                 },
//               ),
//               sh30,
//               CustomButton(text: 'Save', onPressed: () {}),
//               sh30
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_dropdown.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';

class EditProfileView extends StatefulWidget {
  final String? initialName;
  final String? initialGender;
  final String? initialLocation;
  final String? initialAge;
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
  final ProfileController _controller = Get.find<ProfileController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController petInfoController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  String? selectedCategory;
  String? selectedOwnerRelationshipStatus;
  String? selectedOwnerGender;
  String? selectedGender;

  XFile? selectedImage; // For profile picture
  XFile? coverImage;   // For cover photo
  XFile? ownerImage;   // For owner profile picture
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize with initial values from ProfileView
    nameController.text = widget.initialName ?? '';
    locationController.text = widget.initialLocation ?? '';
    ageController.text = widget.initialAge ?? '';
    petInfoController.text = widget.initialPetInfo ?? '';
    ownerNameController.text = widget.initialOwnerName ?? '';
    selectedCategory = widget.initialCategory;
    selectedOwnerRelationshipStatus = widget.initialOwnerRelationshipStatus;
    selectedOwnerGender = widget.initialOwnerGender;
    selectedGender = widget.initialGender; // Assuming gender is part of initial data
  }

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (type == 'image') selectedImage = pickedFile;
        if (type == 'coverImage') coverImage = pickedFile;
        if (type == 'ownerImage') ownerImage = pickedFile;
      });
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
      body: SingleChildScrollView(
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
                        image: coverImage != null
                            ? FileImage(File(coverImage!.path))
                            : NetworkImage(AppImages.groupOfDogs) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => pickImage(ImageSource.gallery, 'coverImage'),
                      child: Container(
                        height: 30,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: Colors.black),
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
                          backgroundImage: selectedImage != null
                              ? FileImage(File(selectedImage!.path))
                              : NetworkImage(AppImages.profileImage)
                          as ImageProvider,
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
              // Remove Image option (placeholder)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Remove Image',
                  style: h5,
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
              ),
              sh16,
              // Category
              Text('Category', style: h2.copyWith(fontSize: 18)),
              sh8,
              CustomDropdown(
                value: selectedCategory,
                items: ['Cat', 'Dog', 'Bird', 'Exotic Animal', 'Farm Animal'],
                hintText: 'Select your pet category',
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                  log('Selected category: $value');
                },
              ),
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
                      backgroundImage: ownerImage != null
                          ? FileImage(File(ownerImage!.path))
                          : null,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => pickImage(ImageSource.gallery, 'ownerImage'),
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
                  // if (nameController.text.isEmpty ||
                  //     genderController.text.isEmpty ||
                  //     locationController.text.isEmpty ||
                  //     ageController.text.isEmpty ||
                  //     selectedCategory == null ||
                  //     petInfoController.text.isEmpty ||
                  //     ownerNameController.text.isEmpty ||
                  //     selectedOwnerRelationshipStatus == null ||
                  //     selectedOwnerGender == null) {
                  //   Get.snackbar('Error', 'All fields are required',
                  //       backgroundColor: AppColors.orange,
                  //       colorText: AppColors.white);
                  //   return;
                  // }

                   _controller.updateProfile(
                    name: nameController.text,
                    gender: genderController.text,
                    location: locationController.text,
                    age: ageController.text,

                    category: selectedCategory!,
                    petInfo: petInfoController.text,
                    ownerName: ownerNameController.text,
                    ownerRelationshipStatus: selectedOwnerRelationshipStatus!,
                    ownerGender: selectedOwnerGender!,
                    selectedImage: selectedImage,
                    ownerImage: ownerImage,
                    coverImage: coverImage,
                  );
                  Get.back();
                },
              ),
              sh30,
            ],
          ),
        ),
      ),
    );
  }
}