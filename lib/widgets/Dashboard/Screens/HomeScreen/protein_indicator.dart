import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class ProteinIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  "assets/home_screen/Meat.png",
                  scale: 2.6,
                ),
                Text(
                  " Protein",
                  style: FitnessAppTheme.carbsIndicator,
                ),
              ],
            ),
            LinearPercentIndicator(
              percent: 0.6,
              width: constraints.maxWidth,
              lineHeight: constraints.maxHeight * 0.1,
              backgroundColor: Colors.black26,
              animation: true,
              animationDuration: 2000,
              linearGradient: LinearGradient(colors: <Color>[
                Colors.red.withOpacity(0.1),
                Colors.red.withOpacity(0.2),
                Colors.red.withOpacity(0.3),
                Colors.red.withOpacity(0.4),
                Colors.red.withOpacity(0.5),
                Colors.red.withOpacity(0.6),
                Colors.red.withOpacity(0.7),
                Colors.red.withOpacity(0.8),
                Colors.red.withOpacity(0.9),
                Colors.red.withOpacity(1),
              ]),
              clipLinearGradient: true,
              linearStrokeCap: LinearStrokeCap.roundAll,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // stream builder
                StreamBuilder(
                    stream: DatabaseService().getUserDocStream(
                        id: FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data as DocumentSnapshot;
                        var totalCarbs =
                            double.parse(data['remainingProteins'].toString())
                                .toInt()
                                .toString();
                        return Text(
                          totalCarbs,
                          style: FitnessAppTheme.eatenIndicatorValue,
                        );
                      } else {
                        return const Text(
                          "",
                          style: FitnessAppTheme.eatenIndicatorValue,
                        );
                      }
                    }),

                Text(
                  " grams left",
                  style: FitnessAppTheme.carbsIndicatorUnit,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static const TextStyle indicator = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static const TextStyle indicator2 = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.blue,
  );

  static const TextStyle indicator3 = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.black45,
  );
}
