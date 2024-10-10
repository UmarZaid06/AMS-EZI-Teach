import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_model.dart';

class FirebaseService {
  /// Variables
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Create User With Email and Password
  Future<User?> createUser(String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  /// Add User Data to FireStore
  Future<void> addUserToFirestore(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }


  /// Upload Image to Firebase Storage
  Future<String> uploadProfileImage(String userId, String imagePath) async {
    final ref = _storage.ref().child('profile_images/$userId.jpg');
    final uploadTask = await ref.putFile(File(imagePath));
    return await uploadTask.ref.getDownloadURL();
  }

  /// Update User Profile Image in Firebase Storage
  Future<void> updateProfileImageUrl(String userId, String imagePath) async {
     await uploadProfileImage(userId, imagePath);
    await _firestore.collection('users').doc(userId).update({
      'profileImageUrl': imagePath,
    });
  }


}
