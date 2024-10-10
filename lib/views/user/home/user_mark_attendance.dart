import 'package:ams/common/styles/spacing_style.dart';
import 'package:ams/common/widgets/custom_shaps/containers/rounded_container.dart';
import 'package:ams/common/widgets/list_tiles/user_info_tile.dart';
import 'package:ams/utils/constants/colors.dart';
import 'package:ams/utils/constants/sizes.dart';
import 'package:ams/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/images/u_circular_image.dart';
import '../../../controllers/attendance_controller.dart';
import '../../../controllers/user_controller.dart';
import '../profile/widgets/profile_menu.dart';

class UserMarkAttendance extends StatelessWidget {
  const UserMarkAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final attendanceController = Get.put(AttendanceController());

    return Padding(
      padding: AppSpacingStyle.paddingWithAppBarHeight,
      child: Column(
        children: [
          const SizedBox(height: AppSizes.spaceBtwSections),
          AppRoundedContainer(
            width: double.infinity,
            height: AppHelperFunctions.screenHeight() * 0.45,
            backgroundColor: AppColors.secondary.withOpacity(0.7),
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppCircularImage(image: userController.user.value?.profileImageUrl ?? '', isNetworkImage: true, padding: 0),
                    const SizedBox(width: AppSizes.spaceBtwItems),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${userController.user.value?.firstName ?? ''} ${userController.user.value?.lastName ?? ''}", style: Theme.of(context).textTheme.headlineSmall!.apply(color: AppColors.white),),
                        Text(userController.user.value?.email ?? '', style: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.white),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                AppProfileMenu(onPressed: () {}, title: 'Father Name', value: userController.user.value?.fatherName ?? ''),
                AppProfileMenu(onPressed: () {}, title: 'Roll No', value: '24'),
                AppProfileMenu(onPressed: () {}, title: 'Class', value: '10'),
                const SizedBox(height: AppSizes.spaceBtwItems),
                
                Obx(() => AppUserInfo(
                  title: 'Attendance',
                  subTitle: 'Are you present today?',
                  trailing: Switch(value: attendanceController.isAttendanceMarked.value,
                    onChanged: (value) {
                      if (value) {
                        attendanceController.markAttendance();
                      }
                    },
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
