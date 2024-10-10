import 'package:ams/utils/constants/colors.dart';
import 'package:ams/utils/constants/sizes.dart';
import 'package:ams/utils/helpers/helper_functions.dart';
import 'package:ams/views/user/home/user_attendance_record.dart';
import 'package:ams/views/user/home/user_leave_request.dart';
import 'package:ams/views/user/home/user_mark_attendance.dart';
import 'package:ams/views/user/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'common/widgets/custom_shaps/containers/primary_header_container.dart';
import 'common/widgets/list_tiles/user_profile_tile.dart';
import 'controllers/user_controller.dart';

class UserNavigationMenu extends StatelessWidget {
  const UserNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final controller = Get.put(NavigationController());
    final darkMode = AppHelperFunctions.isDarkMode(context);

    return FutureBuilder(
      future: userController.fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading user data')),
          );
        }

        return Scaffold(
          bottomNavigationBar: Obx(
            () => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              backgroundColor: darkMode ? AppColors.black : AppColors.white,
              indicatorColor: darkMode
                  ? AppColors.white.withOpacity(0.1)
                  : AppColors.black.withOpacity(0.1),
              destinations: const [
                NavigationDestination(
                    icon: Icon(Iconsax.home), label: 'Mark Attendance'),
                NavigationDestination(
                    icon: Icon(Iconsax.send_sqaure_24), label: 'Leave Request'),
                NavigationDestination(
                    icon: Icon(Icons.school_outlined),
                    label: 'Attendance Record'),
              ],
            ),
          ),
          body: Column(
            children: [
              /// --Header
              AppPrimaryHeaderContainer(
                child: Column(
                  children: [
                    const SizedBox(height: AppSizes.spaceBtwSections * 1.5),

                    /// User Profile Card
                    AppUserProfileTile(
                      onPressed: () => Get.to(() => const UserProfileScreen()),
                    ),

                    const SizedBox(height: AppSizes.spaceBtwSections),
                  ],
                ),
              ),

              /// Body content based on selected index
              Obx(() => controller.screens[controller.selectedIndex.value]),
            ],
          ),
        );
      },
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  /// List of screens corresponding to the navigation bar
  final List<Widget> screens = [
    const UserMarkAttendance(),
    const UserLeaveRequest(),
    const UserAttendanceRecord(), // Corrected class name
  ];
}
