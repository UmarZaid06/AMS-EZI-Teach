import 'package:ams/utils/constants/colors.dart';
import 'package:ams/utils/constants/image_strings.dart';
import 'package:ams/utils/constants/sizes.dart';
import 'package:ams/utils/helpers/helper_functions.dart';
import 'package:ams/views/admin/approve_leave_requests_page.dart';
import 'package:ams/views/admin/grading_system_page.dart';
import 'package:ams/views/admin/manage_attendance/manage_attendance_page.dart';
import 'package:ams/views/user/login/user_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'common/widgets/custom_shaps/containers/primary_header_container.dart';
import 'common/widgets/images/u_circular_image.dart';
import 'controllers/user_controller.dart';

class AdminBottomNavbar extends StatelessWidget {
  const AdminBottomNavbar({super.key});

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
                    icon: Icon(Iconsax.home), label: 'Attendance'),
                NavigationDestination(
                    icon: Icon(Iconsax.send_sqaure_24),
                    label: 'Request Approval'),
                NavigationDestination(
                    icon: Icon(Icons.school_outlined), label: 'Grading System'),
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
                    ListTile(
                      leading: SizedBox(
                        width: 56,
                        height: 56,
                        child: AppCircularImage(
                            image: AppImages.appLogo, padding: 0),
                      ),
                      title: Text(
                        "EZI Teach",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: AppColors.white),
                      ),
                      subtitle: Text(
                        'eziteach@gmail.com',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: AppColors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () =>
                            Get.offAll(() => const UserLoginScreen()),
                        icon:
                            const Icon(Iconsax.logout, color: AppColors.white),
                      ),
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
    const AdminManageAttendancePage(),
    const AdminApproveLeaveRequestsPage(),
    const AdminGradingSystemPage(),
  ];
}
