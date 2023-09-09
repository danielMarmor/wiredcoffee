import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wiredcoffee/models/user.dart';
import 'package:wiredcoffee/providers/loadingIndicatorProvider.dart';
import 'package:wiredcoffee/screens/business/authWrapper.dart';
import 'package:wiredcoffee/shared/constants.dart';
import 'package:wiredcoffee/shared/widgets/loadedScaffoldBody.dart';
import 'package:wiredcoffee/shared/widgets/myButton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../providers/userProvider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditMode = false;
  File? _pendingImage;
  bool _isMale = true;

  late TextEditingController userName;
  late TextEditingController email;
  late TextEditingController phoneNumber;

  @override
  void dispose() {
    _pendingImage = null;
    email.dispose();
    userName.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  bool isValidated(BuildContext context) {
    if (email.text.isEmpty ||
        userName.text.isEmpty ||
        phoneNumber.text.isEmpty) {
      showMessage("Please dont type empty values!", context);
      return false;
    }
    return true;
  }

  Future<void> submit(BuildContext context, UserProvider userProv) async {
    final validated = isValidated(context);
    if (!validated) {
      return;
    }
    LoadingIndicatorProvider.loading.value = true;
    final updProfile = UserModel(
        userName: userName.text,
        email: email.text,
        phoneNumber: phoneNumber.text,
        gender: _isMale ? "Male" : "Female",
        imageUrl: userProv.user!.imageUrl);
    try {
      await userProv.setUserData(UserModel.toJson(updProfile), _pendingImage);
      _pendingImage = null;
      setState(() {
        _isEditMode = false;
      });
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      showSuccessMessage("Your Data has Updated!", context);
    } catch (err) {
      showMessage(requestCouldNotCompletedMessage, context);
    } finally {
      LoadingIndicatorProvider.loading.value = false;
    }
  }

  void editProfile(BuildContext context) async {
    setState(() {
      _isEditMode = true;
    });
  }

  Future<void> getImageFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pendingImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildDetailsLine(String leadingText, String dataText) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 55.0,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              leadingText,
              style: const TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              dataText,
              style: const TextStyle(
                  fontSize: 17,
                  //color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditLine(String headerText, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: headerText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.blueGrey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.blue, width: 2.0)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0)));
  }

  Widget _buildProfileImage(UserModel user) {
    return _pendingImage != null
        ? CircleAvatar(
            radius: 65.0,
            backgroundImage: FileImage(_pendingImage!),
            //  AssetImage("assets/defaultUser.jpg"),
          )
        : user.imageUrl != null && user.imageUrl!.isNotEmpty
            ? CircleAvatar(
                radius: 65.0, backgroundImage: NetworkImage(user.imageUrl!)
                //
                )
            : const CircleAvatar(
                radius: 65.0,
                backgroundImage: AssetImage("assets/defaultUser.jpg"),
                //  AssetImage("assets/defaultUser.jpg"),
              );
  }

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: true);
    final userData = userProv.user;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0.0,
          centerTitle: true,
          leading: _isEditMode
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isEditMode = false;
                    });
                  },
                  icon: const Icon(Icons.close, color: Colors.redAccent))
              : IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AuthWrapper()));
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black)),
          actions: _isEditMode
              ? <Widget>[
                  IconButton(
                      onPressed: () async {
                        await submit(context, userProv);
                      },
                      icon: const Icon(Icons.check, color: Colors.greenAccent)),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.notifications,
                  //         color: Colors.black)),
                ]
              : [],
        ),
        body: SafeArea(
            child: LoadedScaffoldBody(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 200,
                        child: _buildProfileImage(userData!)),
                    Padding(
                      padding: const EdgeInsets.only(left: 220, top: 115),
                      child: GestureDetector(
                        onTap: () {
                          getImageFromGallery();
                        },
                        child: !_isEditMode
                            ? Container()
                            : Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.edit,
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Builder(builder: (context) {
                    userName = TextEditingController(text: userData!.userName);
                    email = TextEditingController(text: userData.email);
                    phoneNumber =
                        TextEditingController(text: userData.phoneNumber);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _isEditMode
                          ? [
                              _buildEditLine("Name", userName),
                              _buildEditLine("Email", email),
                              _buildEditLine("Phone Number", phoneNumber),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isMale = !_isMale;
                                  });
                                },
                                child: Container(
                                  height: 55.0,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0))),
                                  alignment: Alignment.centerLeft,
                                  child: Text(userData.gender,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ]
                          : [
                              _buildDetailsLine("Name", userData.userName),
                              _buildDetailsLine("Email", userData.email),
                              _buildDetailsLine(
                                  "Phone Number", userData.phoneNumber),
                              _buildDetailsLine("Gender", userData.gender),
                            ],
                    );
                  }),
                ),
                !_isEditMode
                    ? Container(
                        height: 55.0,
                        width: 200.0,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: MyButton(
                            name:
                                _isEditMode ? "Update Profile" : "Edit Profile",
                            submit: editProfile))
                    : Container(
                        height: 55.0,
                      )
              ],
            ),
          ),
        )));
  }
}
