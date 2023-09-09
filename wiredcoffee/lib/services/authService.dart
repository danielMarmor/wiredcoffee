// ignore: file_names
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:wiredcoffee/shared/constants.dart';

import '../models/user.dart';

class AuthService {
  AuthService();

  final _authentication = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;

  Future<UserCredential?> registerWithEmailAndPassword(
      email, password, Map<String, dynamic> userMap) async {
    try {
      //CREATE AUTH
      UserCredential authResult = await _authentication
          .createUserWithEmailAndPassword(email: email, password: password);
      //USER DATA
      await _database
          .collection("users")
          .doc(authResult.user!.uid)
          .set(userMap);
      return authResult;
    } on PlatformException catch (err) {
      await deleteUser();
      throw Exception(err.message);
      // ignore: unused_catch_clause
    } catch (err) {
      //AUTH CLEANUP
      await deleteUser();
      throw Exception(err.toString());
    }
  }

  Future<void> deleteUser() async {
    if (_authentication.currentUser != null) {
      await _authentication.currentUser!.delete();
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return authResult;
    } on PlatformException catch (err) {
      throw Exception(err.message);
      // ignore: unused_catch_clause
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    final userDoc = await _database.collection("users").doc(uid).get();
    if (!userDoc.exists) {
      return null;
      //throw Exception("User $uid Not Found");
    }
    final user = UserModel.fromJson(userDoc.data());
    return user;
  }

  Future<void> setUserData(
      Map<String, dynamic> userMap, File? imageToUpload) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String userImageUrl = userMap['imageUrl'];
    String? uploadedImageUrl;
    try {
      if (imageToUpload != null) {
        uploadedImageUrl = await uploadImage(imageToUpload);
        userMap['imageUrl'] = uploadedImageUrl;
      }
      await _database.collection("users").doc(userId).set(userMap);
    } catch (err) {
      //IF OLD IMAGE ====> DONT DO NOTHING, DONT DELETE STORAGE
      final isNewImage = userImageUrl == EMPTY && uploadedImageUrl != null;
      if (isNewImage) {
        await removeImage();
      }
      throw Exception(err);
    }
  }

  Future<String> uploadImage(File image) async {
    final user = FirebaseAuth.instance.currentUser;
    final storageRef = FirebaseStorage.instance.ref();
    final newUserImg = storageRef.child('usersImages/${user!.uid}');
    await newUserImg.putFile(image);
    final url = await newUserImg.getDownloadURL();
    return url;
  }

  Future<void> removeImage() async {
    final user = FirebaseAuth.instance.currentUser;
    final storageRef = FirebaseStorage.instance.ref();
    final newUserImg = storageRef.child('usersImages/${user!.uid}');
    await newUserImg.delete();
  }
}
