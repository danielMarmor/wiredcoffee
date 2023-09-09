import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wiredcoffee/providers/loadingIndicatorProvider.dart';
import 'package:wiredcoffee/screens/authenticate/register.dart';
import 'package:wiredcoffee/shared/widgets/loadedScaffoldBody.dart';
import 'package:wiredcoffee/shared/widgets/myButton.dart';
import 'package:wiredcoffee/shared/widgets/myTextFormField.dart';
import 'package:wiredcoffee/shared/widgets/passwordTextFormField.dart';
import 'package:wiredcoffee/shared/widgets/switchScreen.dart';

import '../../services/authService.dart';
import '../../shared/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

late GlobalKey<FormState>? _loginKey;

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    _loginKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _loginKey = null;
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool isValidated(BuildContext context) {
    if (email.text.isEmpty || password.text.isEmpty) {
      showMessage("Please dont type empty values!", context);
      return false;
    }
    return true;
  }

  Future<void> submit(BuildContext context) async {
    final validated = isValidated(context);
    if (!validated) {
      return;
    }
    try {
      LoadingIndicatorProvider.loading.value = true;
      final usrEmail = email.text;
      final usrPassword = password.text;
      var auth = AuthService();
      await auth.signInWithEmailAndPassword(usrEmail, usrPassword);
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      showSuccessMessage('Sign In Succecfuly!', context);
    } catch (err) {
      showMessage(err.toString(), context);
    } finally {
      LoadingIndicatorProvider.loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          // ignore: avoid_unnecessary_containers
          child: LoadedScaffoldBody(
        child: Form(
          key: _loginKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 250.0,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  //color: Colors.blue[800],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Login',
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
                  height: 300.0,
                  width: double.infinity,
                  //color: Colors.blue[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTextFormField(
                        name: 'Email',
                        controller: email,
                      ),
                      PasswordTextFormField(
                        name: 'Password',
                        controller: password,
                      ),
                      MyButton(name: 'Login', submit: submit)
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                SwitchScreen(
                  name: 'Register',
                  whichAccount: 'Dont Have an account?',
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Register()));
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
