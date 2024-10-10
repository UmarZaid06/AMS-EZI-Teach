import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/admin_controller.dart';

class AdminApproveLeaveRequestsPage extends StatelessWidget {

  const AdminApproveLeaveRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminController());
    return StreamBuilder(
      stream: adminController.getLeaveRequests(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No leave requests found"));
        }
        var requests = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: requests.length,
          itemBuilder: (context, index) {
            var request = requests[index];
            return ListTile(
              // leading: AppCircularImage(image:),
              title: Text(request['reason']),
              subtitle: Text(request['status']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      adminController.approveLeaveRequest(request.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      adminController.rejectLeaveRequest(request.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
