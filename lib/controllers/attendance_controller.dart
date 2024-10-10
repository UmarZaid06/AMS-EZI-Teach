import 'package:ams/user_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AttendanceController extends GetxController {
  static AttendanceController get instance => Get.find();

  /// Variables
  final leaveReason = TextEditingController();
  var userId = FirebaseAuth.instance.currentUser!.uid;
  final attendanceRef = FirebaseFirestore.instance.collection('attendance');
  final RxBool isAttendanceMarked = false.obs;
  final deviceStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkTodayAttendance();
  }

  /// Check Today Attendance
  void checkTodayAttendance() {
    String todayKey = _getTodayKey();

    bool? storedStatus = deviceStorage.read(todayKey);
    isAttendanceMarked.value = storedStatus ?? false;
  }

  /// Attendance
  void markAttendance() async {
    if (isAttendanceMarked.value) {
      Get.snackbar("Error", "Attendance already marked for today");
      return;
    }

    try {
      await attendanceRef.add({
        'userId': userId,
        'date': DateTime.now(),
        'status': 'Present',
      });

      String todayKey = _getTodayKey();
      deviceStorage.write(todayKey, true);

      isAttendanceMarked.value = true;
      Get.snackbar("Success", "Attendance marked successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  /// Leave Request
  void sendLeaveRequest(String reason) async {
    try {
      await FirebaseFirestore.instance.collection('leave_requests').add({
        'userId': userId,
        'date': DateTime.now(),
        'reason': reason,
        'status': 'Pending',
      });
      Get.snackbar("Success", "Leave request sent");
      Get.offAll(() => const UserNavigationMenu());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// To make difference btw tow attendance
  String _getTodayKey() {
    final today = DateTime.now();
    return 'attendanceMarked_${today.year}-${today.month}-${today.day}';
  }
}
