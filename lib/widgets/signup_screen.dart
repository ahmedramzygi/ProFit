import 'package:flutter/material.dart';
import 'package:profit/design/ThemeUI.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/services/validate.dart';
import 'package:profit/widgets/login_screen.dart';
import 'package:profit/widgets/loginsucess.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessAppTheme.selectorGrayBackGround,
      appBar: AppBar(
        backgroundColor: FitnessAppTheme.selectorGrayBackGround,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Create New Account',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        elevation: 0,
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthenticationService authServices = AuthenticationService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  checkAuthentication() async {
    auth.authStateChanges().listen((_user) {
      if (_user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Sucess();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formGlobalKey = GlobalKey<FormState>();

    void signup() async {
      final formKey = formGlobalKey.currentState;

      if (formKey!.validate()) {
        formKey.save();
        await authServices.signUpWithEmailAndPassword(
            name: _nameController.text,
            email: _emailController.text,
            password: _passController.text,
            confirmPassword: _confirmPassController.text);

        await AuthenticationService.showMessage(
            AuthenticationService.message, context);
      }

      await checkAuthentication();
    }

    return SingleChildScrollView(
      child: Form(
          key: formGlobalKey,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Column(children: [
                TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Email",

                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    icon: Icon(
                      Icons.email,
                      color: FitnessAppTheme.nearlyBlue,
                    ),
                    //border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (!Validators.validateEmail(value!)) {
                      return "Enter Correct Email";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  obscureText: false,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    icon: Icon(
                      Icons.person,
                      color: FitnessAppTheme.nearlyBlue,
                    ),
                  ),
                  validator: (value) {
                    if (!Validators.validateName(value!)) {
                      return "Enter Correct Name";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: FitnessAppTheme.nearlyBlue,
                    ),
                  ),
                  //controller: _pass,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (!Validators.validatePassword(value!)) {
                      return "Enter Correct Password";
                    } else {
                      // print(_pass.text);
                      return null;
                    }
                  },
                ),
                TextFormField(
                    controller: _confirmPassController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Re-Password",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      icon: Icon(
                        Icons.lock,
                        color: FitnessAppTheme.nearlyBlue,
                      ),
                    ),
                    //controller: _confirmPass,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) return 'Enter Correct Password';
                      if (val != _passController.text) return 'Not Match';
                      return null;
                    }),
                const SizedBox(height: 40),
                ElevatedButton(
                    child: const Text('SIGN UP'),
                    onPressed: signup,
                    style: ElevatedButton.styleFrom(
                      primary: FitnessAppTheme.nearlyBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Already have an Account? Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: FitnessAppTheme.nearlyDarkBlue,
                      ),
                    ))
              ]))),
    );
  }
}
