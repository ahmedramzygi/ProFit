class UserProfile {
 // late String _id;
  late String _name;
  late String _email;
  late int _goal;
  late String _age;
  late String _height;
  late String _weight;
  late bool _gender;
  late double _activityLevel;
  late double _calories;

  UserProfile(dynamic obj) {
  //  _id =  obj['id'];
    _name = obj['name'];
    _email = obj['email'];
    _goal = obj['goal'];
    _age = obj['age'];
    _height = obj['height'];
    _weight = obj['weight'];
    _gender = obj['gender'];
    _activityLevel = obj['activityLevel'];
    _calories = obj['calories'];
  }
  UserProfile.fromMap(Map<String, dynamic> data) {
    // _id =  data['id'];
    _name = data['name'];
    _email = data['email'];
    _goal = data['goal'];
    _age = data['age'];
    _height = data['height'];
    _weight = data['weight'];
    _gender = data['gender'];
    _activityLevel = data['activityLevel'];
    _calories = data['calories'];
  }

  Map<String, dynamic> toMap() => {
        'name': _name,
        'email': _email,
        'goal': _goal,
        'age': _age,
        'height': _height,
        'weight': _weight,
        'gender': _gender,
        'activityLevel': _activityLevel,
        'calories': _calories,
      };
   //   String getId() => _id;

      // setId(String id){
      //     _id = id;
      // }
}