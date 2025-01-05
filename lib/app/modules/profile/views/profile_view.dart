import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: Text(
          'Profile',
        ),
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
              // Cover photo and profile picture
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(AppImages.profile),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey),
                  ),
                  Positioned(
                    bottom: -50,
                    left: MediaQuery.of(context).size.width / 2 - 66,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_picture.jpg'),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.black,
                          child: Icon(Icons.add, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              // Profile info
              Text(
                'Piku_The_King',
                style: h2.copyWith(fontSize: 20),
              ),
              Row(
                children: [
                  Image.asset(
                    AppImages.location,
                    scale: 4,
                  ),
                  sw8,
                  Text(
                    '231-A, Florida, USA.',
                    style: h4,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      onPressed: () {},
                      text: '0 Friends',
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.black,
                      textStyle: h3.copyWith(color: AppColors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      onPressed: () {},
                      text: 'Edit Profile',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Attributes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: AttributeTile(label: 'Gender', value: 'Male')),
                  sw12,
                  Expanded(child: AttributeTile(label: 'Age', value: '1 Year')),
                  sw12,
                  Expanded(child: AttributeTile(label: 'Category', value: 'Cat')),
                ],
              ),
              SizedBox(height: 20),
              // Pet info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pet info',
                    style: h2.copyWith(fontSize: 18),
                  ),
                  Image.asset(AppImages.lock,scale: 4,),
                ],
              ),
              Text(
                'Hi, I’m Gultush! I’m a cheerful and energetic cat who loves to explore and play all day long. My favorite activities include chasing toys, basking in sunny spots, and snuggling up for cozy naps. I’m not just a pet—I’m a bundle of joy that brings endless happiness and love to my family! 🐾✨',
                style: h4,
              ),
              SizedBox(height: 20),
              // Pet Owner Info
              Text('Pet Owner',style: h3,),
              sh12,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.fillColorTwo,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/owner_picture.jpg'),
                  ),
                  title: Text(
                    'Ria Tamanna',
                    style: h4,
                  ),
                  subtitle: Text(
                    'Single\nFemale',
                    style: h6,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Posts and Collections
              Row(
                children: [
                  Expanded(child: InfoCard(label: '0 Posts')),
                  Expanded(child: InfoCard(label: '0 Collections')),
                ],
              ),
              SizedBox(height: 20),
              // Footer illustration
              Image.asset(
                'assets/footer_dogs.png',
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttributeTile extends StatelessWidget {
  final String label;
  final String value;

  const AttributeTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryOrangeColor),
        color: AppColors.fillColorTwo,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: h4.copyWith(color: AppColors.secondaryOrangeColor),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: h4.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;

  const InfoCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
