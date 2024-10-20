import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:sheet_client/controller/file_controller.dart';
import 'package:sheet_client/model/admin.dart';
import 'package:sheet_client/pages/signup_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Rx<User?> _user;

  RxBool isConnected = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user, setScreen);
  }

  @override
  Future<void> onInit() async {
    _checkInternetConnection();
    super.onInit();
  }

  setScreen(User? user) {
    if (user == null) {
      Get.toNamed("/login");
    } else {
      Get.put(FileController());
      Get.toNamed("/home");
    }
  }

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('design3dprof.hu');
      if (response.isNotEmpty) {
          isConnected.value = true;
          Get.snackbar("Internet Connection", "Internet connection ready");
      }
    } on SocketException catch (err) {
        isConnected.value = false;
        Get.snackbar("Internet Connection", "Internet connection not ready");
      print(err);
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      getAdmin(_userCredential.user!.uid);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        "$e error",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(const SignUpPage());
      //createAdmin("Admin", email, password);
    }
  }

  Future<Admin> getAdmin(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("users").doc(uid).get();
      return Admin.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      Get.snackbar(
        "Error get Admin",
        "$e error",
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  void createAdmin(String name, String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create admin
      Admin _user = Admin(
        id: _authResult.user!.uid,
        name: name,
        email: _authResult.user!.email,
      );
      Get.snackbar(
        "Registration",
        "Your registration $name is ready!",
        snackPosition: SnackPosition.BOTTOM,
      );
      if (await createNewAdmin(_user)) {
        login(email, password);
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        "$e error",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> createNewAdmin(Admin admin) async {
    try {
      await _firestore.collection("users").doc(admin.id).set({
        "name": admin.name,
        "email": admin.email,
      });
      return true;
    } catch (e) {
      Get.snackbar(
        "Error create new Admin",
        "$e error",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
     try {
       _auth.sendPasswordResetEmail(email: email);
       Get.snackbar(
         "Email sent",
         "$email",
         snackPosition: SnackPosition.BOTTOM,
       );
     } catch (e) {
       print(e);
     }

  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
    SystemNavigator.pop();
  }
}
