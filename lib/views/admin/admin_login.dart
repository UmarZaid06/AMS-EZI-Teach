import 'package:ams/admin_bottom_navbar.dart';
import 'package:ams/common/styles/spacing_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: AppSpacingStyle.paddingWithAppBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Email
          TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: AppTexts.email)),
          const SizedBox(height: AppSizes.spaceBtwInputField),

          /// Password
          TextFormField(obscureText: true, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.password_check), labelText: AppTexts.password, suffixIcon: Icon(Iconsax.eye_slash))),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Log In Button
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const AdminBottomNavbar()), child: const Text(AppTexts.logIn))),
          const SizedBox(height: AppSizes.spaceBtwItems),
        ],
      ),
    ));
  }
}
