import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharohar/constants/firebase_constants.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // login method
  Future<UserCredential?> loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      //   VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // signup method
  Future<UserCredential?> signupMethod({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      //   VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // storing data method
  storeUserData(UserModel user) async {
    DocumentReference store = await FirebaseFirestore.instance
        .collection("Users") // Document we are adding to
        .doc(user.sId); // searching our Collection
    store.set({
      'uid': user.sId,
      'name': user.fullName,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'profileProgress': 1,
      'building': user.address,
      'city': user.city,
      'state': user.state,
      'pincode': user.pinCode,
      'role': "buyer",
      'updatedOn': DateTime.now(),
      'createdOn': DateTime.now(),
    });
  }

  signOutMethod(BuildContext context) async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
