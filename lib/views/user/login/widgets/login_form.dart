import 'package:ams/views/admin/admin_login.dart';
import 'package:ams/views/user/signup/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/user_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

class AppLoginForm extends StatelessWidget {
  const AppLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final authController = Get.put(AuthController());
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Column(
        children: [
          /// Email
          TextFormField(
            validator: (value) => AppValidator.validateEmail(value),
            controller: userController.email,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: AppTexts.email),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputField),

          /// Password
          TextFormField(
            validator: (value) => AppValidator.validatePassword(value),
            controller: userController.password,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: AppTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputField / 2),

          /// Remember me and Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Remember me
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text(AppTexts.rememberMe)
                ],
              ),

              /// Forget Password
              TextButton(
                  onPressed: () {}, child: const Text(AppTexts.forgetPassword)),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Log In Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => authController.loginUserWithEmailAndPassword(
                      userController.email.text, userController.password.text),
                  child: const Text(AppTexts.logIn))),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// Create Account Button
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const UserSignupScreen()),
                  child: const Text(AppTexts.createAccount))),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// Admin Login Here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: AppSizes.defaultSpace),

              /// Admin Login
              TextButton(
                  onPressed: () => Get.to(() => const AdminLoginScreen()),
                  child: const Text(AppTexts.adminLoginHere)),
            ],
          ),
        ],
      ),
    ));
  }
}
