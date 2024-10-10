import 'package:ams/controllers/attendance_controller.dart';
import 'package:ams/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/text_strings.dart';

class UserLeaveRequest extends StatelessWidget {
  const UserLeaveRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            TextFormField(controller: attendanceController.leaveReason, maxLines: 15,),
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// Submit Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> attendanceController.sendLeaveRequest(attendanceController.leaveReason.text), child: const Text(AppTexts.submit))),
          ],
        ),
      ),
    );
  }
}
