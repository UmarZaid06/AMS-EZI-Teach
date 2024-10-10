import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/admin_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminGradingSystemPage extends StatelessWidget {
  const AdminGradingSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminController());
    String newGrade = '';
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
              title: Text("${user['firstName']} ${user['lastName']}"),
              subtitle: Text("Current Grade: $newGrade"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Get.defaultDialog(
                    title: "Add Grade OR Edit Grade",
                    content: Column(
                      children: [
                        TextField(decoration: const InputDecoration(labelText: 'Enter Grade', hintText: 'e.g., A, B, C',), onChanged: (value) {newGrade = value;},),
                        const SizedBox(height: 10),

                        ElevatedButton(onPressed: () {
                          if (newGrade.isNotEmpty) {adminController.addORUpdateGrade(user.id, newGrade);Get.back();}
                          else {Get.snackbar("Error", "Please enter a grade.");}}, child: const Text("Submit"),),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
