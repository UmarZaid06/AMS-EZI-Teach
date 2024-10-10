import 'package:ams/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_controller.dart';

class UserAttendancePage extends StatelessWidget {

  const UserAttendancePage({super.key, required this.userId});

  final String userId;
  @override
  Widget build(BuildContext context) {
  final adminController = Get.put(AdminController());
    return Scaffold(
      appBar: AppBar(title: const Text("User Attendance")),
      body: StreamBuilder(
        stream: adminController.getUserAttendance(userId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No attendance records found"));
          }
          var records = snapshot.data!.docs;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              var record = records[index];
              return ListTile(
                title: Text(record['status']),
                subtitle: Text(record['date'].toDate().toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Update Attendance",
                      content: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                adminController.updateAttendance(record.id, {'status': 'Present'});
                                Get.back();
                              },
                              child: const Text("Mark Present"),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems,),

                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                adminController.updateAttendance(record.id, {'status': 'Absent'});
                                Get.back();
                              },
                              child: const Text("Mark Absent"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}