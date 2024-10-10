import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  /// Variables
  final attendanceRef = FirebaseFirestore.instance.collection('attendance');
  final leaveRequestsRef = FirebaseFirestore.instance.collection('leave_requests');
  final usersRef = FirebaseFirestore.instance.collection('users');


  Stream<QuerySnapshot> getAllUsers() {
    return usersRef.snapshots();
  }

  /// Get all User Attendance
  Stream<QuerySnapshot> getUserAttendance(String userId) {
    return attendanceRef.where('userId', isEqualTo: userId).snapshots();
  }

/// Update Attendance
  Future<void> updateAttendance(String attendanceId, Map<String, dynamic> data) async {
    try {
      await attendanceRef.doc(attendanceId).update(data);
      Get.snackbar("Success", "Attendance updated");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Leave Request
  Stream<QuerySnapshot> getLeaveRequests() {
    return leaveRequestsRef.snapshots();
  }

/// Approve Leave Request
  Future<void> approveLeaveRequest(String requestId) async {
    try {
      await leaveRequestsRef.doc(requestId).update({'status': 'Approved'});
      Get.snackbar("Success", "Leave request approved");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Reject Leave Request
  Future<void> rejectLeaveRequest(String requestId) async {
    try {
      await leaveRequestsRef.doc(requestId).update({'status': 'Rejected'});
      Get.snackbar("Success", "Leave request rejected");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// To Add or Upgrade User Grade
  Future<void> addORUpdateGrade(String userId, String grade) async {
    if(grade == ''){
      try {
        await FirebaseFirestore.instance.collection('grades').add({
          'grade': grade,
        });
        Get.snackbar("Success", "user grade modify...");
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
    else{
      try {
        await usersRef.doc(userId).update({'grade': grade});
        Get.snackbar("Success", "Grade added/updated successfully");
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }
}
