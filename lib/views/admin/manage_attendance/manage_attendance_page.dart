import 'package:ams/common/widgets/images/u_circular_image.dart';
import 'package:ams/views/admin/manage_attendance/user_attendance_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_controller.dart';

class AdminManageAttendancePage extends StatelessWidget {
  const AdminManageAttendancePage({super.key});


  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminController());
    return StreamBuilder(
      stream: adminController.getAllUsers(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No users found"));
        }
        var users = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            return ListTile(
              leading: AppCircularImage(image: user['profileImageUrl'], isNetworkImage: true, padding: 0,),
              title: Text("${user['firstName']} ${user['lastName']}"),
              subtitle: Text(user['email']),
              onTap: () {
                Get.to(() => UserAttendancePage(userId: user.id));
              },
            );
          },
        );
      },
    );
  }
}
