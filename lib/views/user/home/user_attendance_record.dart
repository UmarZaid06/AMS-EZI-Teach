import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/attendance_controller.dart';

class UserAttendanceRecord extends StatelessWidget {
  const UserAttendanceRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceController());
    return StreamBuilder(
      stream: attendanceController.attendanceRef
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return const Center(child: Text("No attendance records found"));
        }
        var records = snapshot.data.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: records.length,
          itemBuilder: (context, index) {
            var data = records[index].data();
            return ListTile(title: Text(data['status']), subtitle: Text(data['date'].toDate().toString()),
            );
          },
        );
      },
    );
  }
}
