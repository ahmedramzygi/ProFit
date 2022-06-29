import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profit/themes/theme_ui.dart';
import 'package:profit/services/workout_services.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/widgets/Dashboard/navigation_screen.dart';

class BicepCurls extends StatefulWidget {
  @override
  State<BicepCurls> createState() => _BicepCurlsState();
}

class _BicepCurlsState extends State<BicepCurls> {
  late String _responseMessage;
  late String _caloriesBurnt;
  late double _userWeight;
  WorkoutServices workoutServices = WorkoutServices();

  @override
  void initState() {
    super.initState();
    _responseMessage = "0";
    _caloriesBurnt = "0";
  }

  calculateReps() async {
    final _pickedFile = await workoutServices.getFile();
    setState(() {
      _responseMessage = "...";
      _caloriesBurnt = "...";
    });
    final _pickedFileCompressed = await workoutServices.compressFile(_pickedFile);
    final _response = await workoutServices.uploadFile(_pickedFileCompressed, "biceps");
    _userWeight = await DatabaseService().getWeight(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      _responseMessage = _response;
      // MET formula
      _caloriesBurnt =
          ((6 * 3.5 * _userWeight / 200) * (double.parse(_responseMessage) * 2) / 60).toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ProFit"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/workout_screen/bicep_icon_flipped.png',
                  scale: 3,
                ),
                Text(
                  " BICEP CURLS ",
                  style: FitnessAppTheme.workoutTitle,
                ),
                Image.asset(
                  'assets/workout_screen/bicep_icon.png',
                  scale: 3,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/workout_screen/counter.png',
                  scale: 1,
                ),
                Text(
                  " Reps Count",
                  style: FitnessAppTheme.repsCountTitle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _responseMessage,
                  style: FitnessAppTheme.repsCountValue,
                ),
                Text(
                  " Reps",
                  style: FitnessAppTheme.repsCountUnit,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/workout_screen/fire.png',
                  scale: 1,
                ),
                Text(
                  " You have burnt",
                  style: FitnessAppTheme.repsCountTitle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _caloriesBurnt,
                  style: FitnessAppTheme.repsCountValue,
                ),
                Text(
                  " KCal",
                  style: FitnessAppTheme.repsCountUnit,
                ),
              ],
            ),
            ElevatedButton(
              child: Text(
                "Upload my workout",
                style: FitnessAppTheme.upload,
              ),
              onPressed: calculateReps,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(
                  MediaQuery.of(context).size.width - 80,
                  MediaQuery.of(context).size.height * 0.08,
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                side: MaterialStateProperty.all(const BorderSide(color: Colors.blue, width: 2)),
                overlayColor: MaterialStateProperty.all(Colors.blue),
              ),
            ),
            Image.asset(
              'assets/workout_screen/bicep.gif',
              scale: 4,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              Text(
                "  Add to my workouts",
                style: FitnessAppTheme.addFood,
              ),
            ],
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )),
            fixedSize: MaterialStateProperty.all(Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.06,
            )),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            // side: MaterialStateProperty.all(const BorderSide(color: Colors.blue, width: 2)),
            overlayColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () async => {
            if (double.parse(_caloriesBurnt) == 0)
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("No Reps Detected"),
                    content: const Text("Please upload your workout video"),
                    elevation: 10,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              }
            else
              {
                DatabaseService().addWorkoutToFirestoreUser(
                  id: FirebaseAuth.instance.currentUser!.uid,
                  name: "Bicep Curls",
                  burnedCalories: double.parse(_caloriesBurnt),
                  duration: (double.parse(_responseMessage) * 2) / 60,
                ),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const TabBarPage()),
                  ModalRoute.withName('/success'),
                )
              }
          },
        ),
      ),
    );
  }
}
