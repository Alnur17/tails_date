import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../controllers/other_pet_controller.dart';

class OtherPetDetailsView extends GetView<OtherPetController> {
  final String petId;
  const OtherPetDetailsView({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final OtherPetController controller = Get.put(OtherPetController());

    // Fetch pet details when the view is loaded
    controller.fetchPetDetails(petId);

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Other Pet Details'),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        var pet = controller.petDetails.value?.data;

        if (pet == null) {
          return Center(child: Text('No pet details available.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: pet.image != null
                        ? NetworkImage(pet.image!)
                        : AssetImage(AppImages.catProfileImage) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pet Name:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(pet.name ?? 'Unknown'),
                ],
              ),
              Divider(
                color: AppColors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gender:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(pet.gender ?? 'Unknown'),
                ],
              ),
              Divider(
                color: AppColors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Age:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(pet.age?.toString() ?? 'Unknown'),
                ],
              ),
              Divider(
                color: AppColors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(pet.category ?? 'Unknown'),
                ],
              ),
              Divider(
                color: AppColors.black,
              ),
              Text(
                'Pet Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                pet.info ?? 'No info available',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }),
    );
  }
}
