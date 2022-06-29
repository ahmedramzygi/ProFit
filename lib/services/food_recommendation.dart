import 'dart:convert';
import 'package:profit/models/food_recommendation.dart';
import 'package:http/http.dart' as http;

class FoodRecommendationServiceAPI {
  // make a post request to the server

// make a function that takes input body and returns a list of food recommendation items
  Future<List<FoodRecommendationItem>> getFoodRecommendation(var body) async {
    var jsonBody = json.encode(body);
  

    var response = await http.post(
      Uri.parse('https://food-calories-nodejs.herokuapp.com/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonBody,
    );
   
    // print the response
 if(response.statusCode == 200){
      // map the response to list of FoodRecomendationItem
      var foodRecomendationItems = (json.decode(response.body) as List)
          .map((i) => FoodRecommendationItem.fromJson(i))
          .toList();
          print(response.body);
      return foodRecomendationItems;
    } else {
      print(response.statusCode);
       print(response.body);
      throw Exception('Failed to load the data');
    }
  }
}
