import 'dart:core';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:profit/widgets/Dashboard/Screens/FoodRecommendationScreen/recommended_food.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({Key? key}) : super(key: key);

  @override
  FoodRecommendationScreenState createState() =>
      FoodRecommendationScreenState();
}

class FoodRecommendationScreenState extends State<FoodRecommendationScreen> {
  //String? selectedValue;
  Map<String, dynamic> userPreferences = {
    "Diet": [],
    "Disease": [],
    "Nutrient": []
  };
  List<String> selectedDiets = [];
  List<String> selectedDiseases = [];
  List<String> selectedNutrients = [];
  List<MultiSelectItem> dietsList = [
    MultiSelectItem('low_fat_diet', 'Low Fat Diet'),
    MultiSelectItem('ketogenic_diet', 'Keto Diet'),
    MultiSelectItem('high_protien_diet', 'High Protein Diet'),
    MultiSelectItem('vegan_diet', 'Vegan Diet'),
    MultiSelectItem('gluten_free_diet', 'Gluten Free Diet')
  ];
  List<MultiSelectItem> diseasesList = [
    MultiSelectItem('anemia', 'Anemia'),
    MultiSelectItem('cancer', 'Cancer'),
    MultiSelectItem('heart_disease', 'Heart Disease'),
    MultiSelectItem('kidney_disease', 'Kidney Disease'),
    MultiSelectItem('hypertension', 'Hypertension')
  ];
  List<MultiSelectItem> nutrientsList = [
    MultiSelectItem('calcium', 'Calcium'),
    MultiSelectItem('iron', 'Iron'),
    MultiSelectItem('fiber', 'Fiber'),
    MultiSelectItem('vitamin_a', 'Vitamin A'),
    MultiSelectItem('vitamin_c', 'Vitamin C'),
    MultiSelectItem('vitamin_d', 'Vitamin D'),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      alignment: Alignment.center,

      // Align however you like (i.e .centerRight, centerLeft)
      child: SingleChildScrollView(
        child: Column(
          children: [
            MultiSelectChipField(
              height: MediaQuery.of(context).size.height * 0.1,
              icon: const Icon(
                Icons.fastfood,
                color: Colors.white,
              ),
              closeSearchIcon: const Icon(
                Icons.fastfood,
              ),
              items: dietsList,
              initialValue: [],
              title: const Text(
                "Select diet you follow",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal),
              ),
              headerColor: Colors.blue,
              decoration: BoxDecoration(
                // color: FitnessAppTheme.grey.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              selectedChipColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              onTap: (values) {
                selectedDiets =
                    values.map((value) => value.toString()).toList();
                // selectedDiet.addAll(values.map((value) => value.toString()).toList());
                print(selectedDiets);
              },
            ),
            const SizedBox(height: 20),
            MultiSelectChipField(
              height: MediaQuery.of(context).size.height * 0.1,
              icon: const Icon(Icons.medical_services, color: Colors.white),
              closeSearchIcon: const Icon(Icons.medical_services),
              items: diseasesList,
              initialValue: [],
              title: const Text(
                "Select diseases you suffer from",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              headerColor: Colors.blue,
              decoration: BoxDecoration(
                // color: FitnessAppTheme.grey.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              selectedChipColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              onTap: (values) {
                selectedDiseases =
                    values.map((value) => value.toString()).toList();
              },
            ),
            const SizedBox(height: 20),
            MultiSelectChipField(
              height: MediaQuery.of(context).size.height * 0.1,
              icon: const Icon(
                Icons.fitness_center,
                color: Colors.white,
              ),
              closeSearchIcon: const Icon(Icons.fitness_center),
              items: nutrientsList,
              initialValue: [],
              title: const Text(
                "Select nutrients you need",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal),
              ),
              headerColor: Colors.blue,
              decoration: BoxDecoration(
                // color: FitnessAppTheme.grey.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              selectedChipColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              onTap: (values) {
                selectedNutrients =
                    values.map((value) => value.toString()).toList();
                // selectedDiet.addAll(values.map((value) => value.toString()).toList());
                print(selectedNutrients);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                primary: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              child: const Text('Recommend '),
              onPressed: () {
                userPreferences.addAll({
                  'Diet': selectedDiets,
                  'Disease': selectedDiseases,
                  'Nutrient': selectedNutrients,
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RecommendedFood(
                              input: userPreferences,
                            )));
                //  FoodRecommendationServiceAPI().getFoodRecommendation(userPreferences);
              },
            )
          ],
        ),
      ),
    );
  }
}
