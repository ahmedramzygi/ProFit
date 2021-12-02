import 'package:flutter/material.dart';
import 'package:profit/design/ThemeUI.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/widgets/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sucess extends StatefulWidget {
  @override
  State<Sucess> createState() => _SucessState();
}

class _SucessState extends State<Sucess> {
  AuthenticationService authServices = AuthenticationService();

  FirebaseAuth auth = FirebaseAuth.instance;

  checkAuthentication() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
       // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => true);
       // Navigator.pop(context);
       // Navigator.pushReplacementNamed(context, '/login');
       Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                  ModalRoute.withName('/'),
                );
       
      }
    });
  }

  // checkAuthenticationGoogle() async {
  //   User? googleUser = await auth.currentUser;

  //   // user = userCredential.user;
  //   if (googleUser == null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) {
  //           return const LoginScreen();
  //         },
  //       ),
  //     );
  //   }
  // }

  void signout() async {
    await authServices.signOutGoogle();
    await authServices.signOut();
    await checkAuthentication();
  }

  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: FitnessAppTheme.selectorGrayBackGround,
        appBar: AppBar(
          automaticallyImplyLeading: false ,
          backgroundColor: FitnessAppTheme.selectorGrayBackGround,
          iconTheme: IconThemeData(color: Colors.black ),
    
          title: const Text('Signed in',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const Text(
                    'Welcome to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      child: const Text('Signout'),
                      onPressed: signout,
                      style: ElevatedButton.styleFrom(
                        primary: FitnessAppTheme.nearlyBlue,
                        elevation: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        fixedSize: const Size(130, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      )),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      child: const Text('Signout google'),
                      onPressed: signout,
                      style: ElevatedButton.styleFrom(
                        primary: FitnessAppTheme.nearlyBlue,
                        elevation: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        fixedSize: const Size(130, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
