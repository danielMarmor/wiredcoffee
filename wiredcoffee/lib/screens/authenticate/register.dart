import 'package:flutter/material.dart';
import 'package:wiredcoffee/models/user.dart';
import 'package:wiredcoffee/providers/loadingIndicatorProvider.dart';
import 'package:wiredcoffee/providers/userProvider.dart';
import 'package:wiredcoffee/screens/business/authWrapper.dart';
import 'package:wiredcoffee/services/authService.dart';
import 'package:wiredcoffee/shared/constants.dart';
import 'package:wiredcoffee/shared/widgets/loadedScaffoldBody.dart';

import '../../shared/widgets/myButton.dart';
import '../../shared/widgets/myTextFormField.dart';
import '../../shared/widgets/passwordTextFormField.dart';
import '../../shared/widgets/switchScreen.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

late GlobalKey<FormState>? _registerKey;

class _RegisterState extends State<Register> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  bool _isMale = true;
  @override
  void initState() {
    _registerKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _registerKey = null;
    userName.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  Future<void> register(BuildContext context) async {
    final validated = isValidated(context);
    if (!validated) {
      return;
    }
    try {
      LoadingIndicatorProvider.loading.value = true;
      final usrEmail = email.text;
      final usrPassword = password.text;
      //final isMale = _isMale;
      final usrDetails = {
        'userName': userName.text,
        'email': email.text,
        'phoneNumber': phoneNumber.text,
        'gender': _isMale ? "Male" : "Female",
        'imageUrl': EMPTY
      };
      final authResult = await UserProvider()
          .registerWithEmailAndPassword(usrEmail, usrPassword, usrDetails);
      if (authResult!.user == null) {
        throw Exception("User Is Empty");
      }
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      showSuccessMessage('Registered Succecfuly!', context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthWrapper()));
    } catch (err) {
      showMessage(requestCouldNotCompletedMessage, context);
    } finally {
      LoadingIndicatorProvider.loading.value = false;
    }
  }

  bool isValidated(BuildContext context) {
    if (email.text.isEmpty ||
        password.text.isEmpty ||
        userName.text.isEmpty ||
        phoneNumber.text.isEmpty) {
      showMessage("Please don't type empty values!", context);
      return false;
    }
    // if (email.text.length > UserModel.settings!['email']['maxLength']) {
    //   showMessage("Email should not be longer than 100 charachters!", context);
    //   return false;
    // }
    // if (userName.text.length > UserModel.settings!['userName']['maxLength']) {
    //   showMessage(
    //       "User Name should not be longer than 20 charachters!", context);
    //   return false;
    // }
    // if (phoneNumber.text.length >
    //     UserModel.settings!['phoneNumber']['maxLength']) {
    //   showMessage(
    //       "Phone Number should not be longer than 11 charachters!", context);
    //   return false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          // ignore: avoid_unnecessary_containers
          child: LoadedScaffoldBody(
        child: Form(
          key: _registerKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 175.0,
                  width: double.infinity,
                  //color: Colors.blue[800],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 500.0,
                  width: double.infinity,
                  //color: Colors.blue[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTextFormField(
                        name: 'UserName',
                        controller: userName,
                      ),
                      MyTextFormField(
                        name: 'Email',
                        controller: email,
                      ),
                      PasswordTextFormField(
                        name: 'Password',
                        controller: password,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMale = !_isMale;
                          });
                        },
                        child: Container(
                          height: 60.0,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3.0))),
                          alignment: Alignment.centerLeft,
                          child: Text(_isMale ? "Male" : "Female",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      MyTextFormField(
                        name: 'Phone Number',
                        controller: phoneNumber,
                      ),
                      MyButton(name: 'Register', submit: register)
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                SwitchScreen(
                  name: 'Login',
                  whichAccount: 'I allready have account',
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
