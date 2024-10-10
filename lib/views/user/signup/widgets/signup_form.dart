import 'package:ams/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/user_controller.dart';
import '../../../../models/user_model.dart';

class AppSignupForm extends StatelessWidget {
  const AppSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final authController = Get.put(AuthController());
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      AppValidator.validateEmptyText('First name', value),
                  controller: userController.firstName,
                  decoration: const InputDecoration(
                    labelText: AppTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwInputField),
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      AppValidator.validateEmptyText('Last name', value),
                  controller: userController.lastName,
                  decoration: const InputDecoration(
                    labelText: AppTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwInputField),

          /// Father Name
          TextFormField(
            validator: (value) =>
                AppValidator.validateEmptyText('Father Name', value),
            controller: userController.fatherName,
            decoration: const InputDecoration(
              labelText: AppTexts.fatherName,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputField),

          /// Email
          TextFormField(
            validator: (value) => AppValidator.validateEmail(value),
            controller: userController.email,
            decoration: const InputDecoration(
              labelText: AppTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputField),

          /// Phone Number
          TextFormField(
            validator: (value) => AppValidator.validatePhoneNumber(value),
            controller: userController.phoneNumber,
            decoration: const InputDecoration(
              labelText: AppTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputField),

          /// Password
          TextFormField(
            validator: (value) => AppValidator.validatePassword(value),
            controller: userController.password,
            decoration: const InputDecoration(
              labelText: AppTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (userController.imageFile.value != null) {
                  UserModel user = UserModel(
                    id: '',
                    firstName: userController.firstName.text,
                    lastName: userController.lastName.text,
                    fatherName: userController.fatherName.text,
                    profileImageUrl: '',
                    email: userController.email.text,
                    password: userController.password.text,
                    phoneNumber: userController.phoneNumber.text,
                  );
                  authController.createUserWithEmailAndPassword(
                    userController.email.text,
                    userController.password.text,
                    user,
                    userController.imageFile.value!.path,
                  );
                } else {
                  Get.snackbar("Error", "Please select a profile image.");
                }
              },
              child: const Text(AppTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
