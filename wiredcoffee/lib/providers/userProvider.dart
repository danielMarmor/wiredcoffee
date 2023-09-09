import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wiredcoffee/services/authService.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  late UserModel? _user;

  UserProvider();

  UserModel? get user => _user;

  Future<void> getUserData() async {
    final authResult = FirebaseAuth.instance.currentUser;
    if (authResult == null) {
      _user = null;
      notifyListeners();
      return;
    }
    final userData = await AuthService().getUserData(authResult.uid);
    _user = userData;
    notifyListeners();
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password, Map<String, dynamic> userMap) async {
    var authResult = await AuthService()
        .registerWithEmailAndPassword(email, password, userMap);
    await getUserData();
    return authResult;
  }

  Future<void> setUserData(Map<String, dynamic> userMap, File? image) async {
    await AuthService().setUserData(userMap, image);
    await getUserData();
  }
}
