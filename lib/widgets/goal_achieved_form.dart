import 'package:flutter/material.dart';
import 'package:profit/design/custom_theme.dart';
import 'package:profit/design/theme.dart';


class GoalAchievedForm extends StatefulWidget {
    const GoalAchievedForm({Key? key, required this.onComplete}) : super(key: key);

  final Function(int futureWorkModel) onComplete;

  @override
  createState() {
    return GoalAchievedFormState();
  }
}

class GoalAchievedFormState extends State<GoalAchievedForm> {
  List<UserModel> dataModels = <UserModel>[];
  int goalAchieved = 1;

  @override
  void initState() {
    super.initState();
    _initializeData();//It is the home default screen where he initially selects the first model as default
  }

  void _initializeData() {
    dataModels.add(
      UserModel(
        true,
        1,
        "lose",
        "Lose Weight",
        "Be slim lose weight",
        20,
      ),
    );
    dataModels.add(
      UserModel(
        false,
        2,
        "maintain",
        "Maintain Weight ",
        "Be healthy ",
        5,
      ),
    );
    dataModels.add(
      UserModel(
        false,
        3,
        "muscle",
        "Gain Weight",
        "Build muscle ",
        20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(40.0).copyWith(left: 25.0, right: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "ProFit",
                style: CustomTheme.title,
              ),
              Text(
                "Choose your goal to achieve",
                style: CustomTheme.subtitle.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  itemCount: dataModels.length,
                  itemBuilder: (BuildContext context, int index){ //converts each item to widget
                    return InkWell(
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          for (var element in dataModels) {
                            element.isSelected = false;
                          }
                          dataModels[index].isSelected = true;
                           goalAchieved= dataModels[index].dietNumber;
                        });
                      },
                      child: RadioItem(dataModels[index]),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextButton(
              child: Text(
                'Agree',
                style: theme.textTheme.button,
              ),
              onPressed: () => widget.onComplete(goalAchieved),
            ),
          )
        ],
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final UserModel _item;
  const RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: _item.isSelected
        ? [DesignTheme.selectorShadow]
            : [DesignTheme.transperentShadow],
        color: _item.isSelected
            ? DesignTheme.whiteColor
            : DesignTheme.selectorGrayBackGround,
        border: Border.all(
            width: 1.0,
            color:
            _item.isSelected ? CustomTheme.mainColor : Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      margin: const EdgeInsets.all(15).copyWith(top: 0.0),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _item.title,
                style: _item.isSelected
                    ? DesignTheme.selectorBigTextAction
                    : DesignTheme.selectorBigText,
              ),
              Text(_item.subtitle, style: DesignTheme.selectorMiniLabel)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: _item.padding),
            child: Container(
              child: _item.isSelected
                  ? Image.asset(
                "assets/selector/" + _item.icon + "Color.png",
                height: 80,
              )
                  : Image.asset(
                "assets/selector/" + _item.icon + ".png",
                height: 80,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserModel {
  bool isSelected;
  final int dietNumber;//It represents which diet you should use(fats,proteins,carbs) depending on the model you choose

  final String icon;//it is the icon that will be in assets folder icons represented by the id of the box
  final String title;//Lose weight,maintain weight,build muscle
  final String subtitle;//description of the title
  final double padding;

  UserModel(this.isSelected, this.dietNumber, this.icon, this.title,
      this.subtitle, this.padding);
}
