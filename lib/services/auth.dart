import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:profit/widgets/loginsucess.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static String message = "";
//signup with email and password
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    User? _user;
    try {
      _user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      _user!.updateDisplayName(name);
      message = 'Register success!';
      // showMessage(message, context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message =
            'The account already exists for that email, try different email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = e.message!;
      }
    }

    // if (_errorMessage != null) {
    //   return _errorMessage;
    // }

    // return 'Register success!';
  }

//---------------------------------------
//signin with email and password

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    User? _user;
    // sharedPreferences = await SharedPreferences.getInstance();
    try {
      _user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      message = 'Register success!';
      // sharedPreferences.setBool('isLogin', true);
      // sharedPreferences.setString('displayName', _user.displayName);
      // sharedPreferences.setString('email', _user.email);
      // sharedPreferences.setBool('isVerified', _user.emailVerified);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found with the credential.';
      } else if (e.code == 'wrong-password') {
        message = 'The password is wrong.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = e.message!;
      }
    }
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    User? user;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = await auth.currentUser;
        // user = userCredential.user;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Sucess();
            },
          ),
        );
        print(user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          message = e.code;
        } else if (e.code == 'invalid-credential') {
          message = e.code;
        }
      }
    }

    //  return user;
  }

  Future<void> signOut() async {
    await auth.signOut();
    print('Normal sign out');
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print('sign out');
  }

  static Future<void> showMessage(String message, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('ProFit Message'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Okay'),
              )
            ],
          );
        });
  }
}
