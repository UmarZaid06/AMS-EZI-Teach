import 'package:ams/common/styles/spacing_style.dart';
import 'package:ams/controllers/auth_controller.dart';
import 'package:ams/views/user/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/images/u_circular_image.dart';
import '../../../common/widgets/section_heading.dart';
import '../../../controllers/user_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final authController = Get.put(AuthController());

    String? profileImageUrl;
    String? firstName = userController.user.value?.firstName;
    String? lastName = userController.user.value?.lastName;
    String? fatherName = userController.user.value?.fatherName;
    String? email = userController.user.value?.email;
    String? phoneNumber = userController.user.value?.phoneNumber;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    /// Profile Picture
                    Obx(() {
                      profileImageUrl = userController.user.value?.profileImageUrl;
                      return SizedBox(
                        width: 120,
                        height: 120,
                        child: AppCircularImage(
                            image: profileImageUrl,
                            isNetworkImage: true,
                            padding: 0),
                      );
                    }),
                    TextButton(
                      onPressed: () {
                        userController.updateImage();
                        profileImageUrl = userController.imageFile.value!.path;
                      },
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              /// Details
              const SizedBox(
                height: AppSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Heading Profile Info
              const AppSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              AppProfileMenu(
                  icon: Iconsax.arrow_right_34,
                  onPressed: () {},
                  title: 'Name',
                  value: '$firstName $lastName'),
              AppProfileMenu(
                  icon: Iconsax.arrow_right_34,
                  onPressed: () {},
                  title: 'Father Name',
                  value: '$fatherName'),

              const SizedBox(height: AppSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              const AppSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              AppProfileMenu(
                  icon: Iconsax.copy,
                  onPressed: () {},
                  title: 'Student Id',
                  value: '559500'),
              AppProfileMenu(
                  icon: Iconsax.arrow_right_34,
                  onPressed: () {},
                  title: 'Email',
                  value: '$email'),
              AppProfileMenu(
                  icon: Iconsax.arrow_right_34,
                  onPressed: () {},
                  title: 'Phone',
                  value: '$phoneNumber'),
              AppProfileMenu(
                  icon: Iconsax.arrow_right_34,
                  onPressed: () {},
                  title: 'Gender',
                  value: 'Male'),
              AppProfileMenu(
                  icon: Iconsax.arrow_right_34,
                  onPressed: () {},
                  title: 'Date Of Birth',
                  value: '03, Feb, 2006'),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Center(
                child: TextButton(
                    onPressed: () => authController.logout(),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
