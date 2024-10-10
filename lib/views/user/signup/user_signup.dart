import 'dart:io';

import 'package:ams/common/styles/spacing_style.dart';
import 'package:ams/views/user/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/user_controller.dart';

class UserSignupScreen extends StatelessWidget {
  const UserSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(AppTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 70,
                        backgroundImage: userController.imageFile.value != null
                            ? FileImage(
                                File(userController.imageFile.value!.path))
                            : null,
                        child: userController.imageFile.value == null
                            ? const Icon(Icons.add_a_photo)
                            : null,
                      ),
                    ),
                    TextButton(
                      onPressed: () => userController.pickImage(),
                      child: const Text('Select Profile Picture'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Form
              const AppSignupForm(),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
