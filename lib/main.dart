// import 'package:calory_calc/blocs/auth/bloc.dart';
// import 'package:calory_calc/providers/local_providers/userProvider.dart';

// import 'package:calory_calc/models/dbModels.dart';
// import 'package:calory_calc/utils/dataLoader.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'widgets/forms/forms.dart';

// ignore_for_file: unused_label

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:profit/utils/calculate_calories.dart';
import 'package:profit/widgets/login_screen.dart';
import 'package:profit/widgets/loginsucess.dart';
import 'package:profit/widgets/onboarding_screen.dart';
import 'package:profit/widgets/activity_level.dart';
import 'package:profit/widgets/goal_achieved_form.dart';
import 'package:profit/widgets/physical_paramters_form.dart';
import 'package:profit/widgets/signup_screen.dart';
import 'design/ThemeUI.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/services/validate.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // checkAuthentication();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      // Call the splash screen first
      // Which calls next the intro page
      home: SplashScreen(),
    );
  }
}

//--->>> Splash screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const IntroPage(),
      splash: 'assets/splash/Logo.png',
      //duration: ,
      splashTransition: SplashTransition.fadeTransition,
      //animationDuration: ,
      //pageTransitionType: ,
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // final _pageController =
  //     PageController(); //It controls the pages of the physical paramters input entry.
  // final _nameController = TextEditingController();
  // final _surnameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  late double
      _activityLevel; //It represents the fitness workmodel that will be included in the BMR calculation(workmodel)
  late int
      _goalAchieved; //It represents the goal of the user whether it is to lose/maintenance/build muscle.
  late bool _gender;
  //Male or Female

  checkAuthentication() async {
    FirebaseAuth.instance.authStateChanges().listen((_user) {
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
    checkAuthentication();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: FitnessAppTheme.background),
        // i want a boolean from DB of authenticate or not to change my inital route
        initialRoute: '/',

        routes: {
          // When navigating to the "/" route, build the HomeScreen widget.
          '/': (context) => OnBoardingScreen(),

          '/goal': (context) => GoalAchievedForm(
                // It is the form of the users goal whether it to lose/maintenance/build muscle.
                onComplete: (int goalAchieved) {
                  setState(() => _goalAchieved = goalAchieved);
                },
              ),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/physical': (context) => PhysicalParametersForm(
                //It is the form widget responsible for taking the user age,height,weight
                ageController: _ageController,
                heightController: _heightController,
                weightController: _weightController,
                onCompleted: (
                  String weight,
                  String height,
                  String age,
                  bool gender,
                ) {
                  setState(() => _gender = gender);
                },
              ),
          '/activity': (context) =>
              ActivityLevelForm(onComplete: (double level) {
                setState(() => _activityLevel = level);
                CalculateCalories(
                    _goalAchieved,
                    _ageController,
                    _heightController,
                    _weightController,
                    _gender,
                    _activityLevel);
              }),

          '/login': (context) => const LoginScreen(),

          '/signup': (context) => SignupScreen(),
          '/sucess': (context) => Sucess()
        },
      ),
    );
  }
}
