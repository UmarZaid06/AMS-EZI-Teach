import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final FirebaseService _firebaseService = FirebaseService();

  /// Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final fatherName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  final Rx<XFile?> imageFile = Rx<XFile?>(null);

  /// Fetching User Data
  Future<void> fetchUser() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      user.value = UserModel.fromSnapshot(doc.data() as Map<String, dynamic>);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Pick User Image
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile;
    }
  }

  /// Update User Image
  Future<void> updateImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile;
      _firebaseService.updateProfileImageUrl(
          FirebaseAuth.instance.currentUser!.uid, imageFile.value!.path);
    }
  }
}
