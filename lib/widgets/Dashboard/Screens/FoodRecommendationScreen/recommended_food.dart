import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:profit/models/food_recommendation.dart';
import 'package:profit/services/food_recommendation.dart';

class RecommendedFood extends StatefulWidget {
  const RecommendedFood({Key? key, required this.input}) : super(key: key);
  final Map<String, dynamic> input;

  @override
  State<RecommendedFood> createState() => _RecommendedFoodState();
}

class _RecommendedFoodState extends State<RecommendedFood> {
  late Future<List<FoodRecommendationItem>> foodRecommendationItems;
  final String foodPhoto =
      "https://image.similarpng.com/very-thumbnail/2021/09/Good-food-logo-design-on-transparent-background-PNG.png";
//  late List<FoodRecommendationItem> foodRecommendationIte;

  @override
  void initState() {
    foodRecommendationItems =
        FoodRecommendationServiceAPI().getFoodRecommendation(widget.input);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return foodBuilder();
  }

  Widget foodBuilder() {
    return Material(
      child: FutureBuilder(
          future: foodRecommendationItems,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Food Recommendation"),
                  centerTitle: true,
                  backgroundColor: Colors.blue,
                ),
                body: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.blueGrey.shade100, width: 4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: Image.network(foodPhoto),
                          title: Text(
                            snapshot.data[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "SourceSansPro",
                                fontSize: 18.0,
                                color: Colors.blue),
                          ),
                          subtitle: Text(
                              "Serving Size: ${snapshot.data[index].servingSizeG} gm\n"
                              "Calories: ${snapshot.data[index].calories}"),
                          isThreeLine: true,
                          trailing: const Icon(
                            Icons.add_task_rounded,
                            color: Colors.blue,
                          ),
                          //         Navigator.of(context).popUntil(ModalRoute.withName('/sucess'));
                        ),
                      );
                    }),
              );
            } else {
              // const double size =  MediaQuery.of(context).size.width;
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Loading......."),
                  centerTitle: true,
                  backgroundColor: Colors.blue,
                ),
                body: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: const LoadingIndicator(
                      indicatorType: Indicator.pacman,
                      colors: [Colors.blue, Colors.red, Colors.yellow],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
