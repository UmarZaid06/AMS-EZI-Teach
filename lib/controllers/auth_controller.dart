import 'package:ams/controllers/user_controller.dart';
import 'package:ams/loading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';
import '../user_bottom_navbar.dart';
import '../views/user/login/user_login.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  /// Variables
  final userController = Get.put(UserController());
  final FirebaseService _firebaseService = FirebaseService();
  Rxn<User> firebaseUser = Rxn<User>();
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// Set Initial Screen
  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const UserLoginScreen());
    } else {
      bool isFirstTime = deviceStorage.read('isFirstTime') ?? true;
      if (isFirstTime) {
        deviceStorage.write('isFirstTime', false);
        Get.offAll(() => const Loading());
      } else {
        Get.offAll(() => const UserNavigationMenu());
      }
    }
  }

  /// User Login With Email and Password
  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      deviceStorage.writeIfNull('isFirstTime', false);
      Get.offAll(() => const UserNavigationMenu());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// User Create Account With Email and Password
  Future<void> createUserWithEmailAndPassword(String email, String password, UserModel user, String imagePath) async {
    try {
      User? newUser = await _firebaseService.createUser(email, password);
      if (newUser != null) {
        String imageUrl = await _firebaseService.uploadProfileImage(newUser.uid, imagePath);
        user.profileImageUrl = imageUrl;
        user.id = newUser.uid;
        await _firebaseService.addUserToFirestore(user);
        deviceStorage.writeIfNull('isFirstTime', true);
        Get.offAll(() => const UserNavigationMenu());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// User Logout Function
  Future<void> logout() async => await _firebaseService.auth.signOut();
}
