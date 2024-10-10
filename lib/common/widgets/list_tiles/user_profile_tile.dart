import 'package:ams/common/widgets/images/u_circular_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/constants/colors.dart';

class AppUserProfileTile extends StatelessWidget {
  const AppUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Obx(() {
      String? profileImageUrl = userController.user.value?.profileImageUrl;
      String? firstName = userController.user.value?.firstName;
      String? lastName = userController.user.value?.lastName;
      String? email = userController.user.value?.email;
      return ListTile(
        leading: SizedBox(
          width: 56,
          height: 56,
          child: AppCircularImage(
              image: profileImageUrl, isNetworkImage: true, padding: 0),
        ),
        title: Text(
          "$firstName $lastName",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: AppColors.white),
        ),
        subtitle: Text(
          '$email',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: AppColors.white),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: AppColors.white),
        ),
      );
    });
  }
}
