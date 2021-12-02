import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:profit/design/ThemeUI.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //--->>> Status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.lightBlue),
    );

    //--->>> Introduction screen
    return SafeArea(
      
      child: IntroductionScreen(
        
        //-->> Pages
        pages: [
          PageViewModel(
            image: buildImage('assets/onboarding/Page1.png', 600),
            title: 'Get the body you want',
            body:
                'Packed with\nour recommendations of\ndiet and workout plans', //Can you decrease the size of text
            decoration: pageDecoration,
            footer:  TextButton(
                    onPressed: () {
                       Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Already have an Account? Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: FitnessAppTheme.nearlyDarkBlue,
                      ),
                    )),
          ),
          PageViewModel(
            image: buildImage('assets/onboarding/Page2.png', 600),
            title: 'Personalized for you',
            body:
                'Diet and workout plans\nmade for you based on\nyour own biometrics and goal',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/onboarding/Page3.png', 600),
            title: 'Stay lean & healthy',
            body:
                'Provided with\ncalories and workout trackers,\ntrack your achievements\ntowards your goal',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/onboarding/Page4.jpg', 600),
            title: 'Science is your coach',
            body:
                'Get AI-based recommendation plans for both\nyour diet and workout',
            decoration: pageDecoration,
          ),
        ],
        //-->> Global screen
        globalBackgroundColor: Colors.white,
        globalHeader: buildImage('assets/onboarding/Logo.png', 100),
        // globalFooter: Text('PROFIT GRADUATION PROJECT DEMO'),
        //-->> Next button
        showNextButton: true,
        nextFlex: 1,
        nextColor: Colors.white,
        next: ElevatedButton(
          onPressed: null,
          child: buildImage('assets/onboarding/Dumbbell.png', 60),
          style: nextButtonStyle,
        ),
        //-->> Skip button
        showSkipButton: true,
        skipFlex: 1,
        skipColor: Colors.white,
        onSkip: null,
        skip: ElevatedButton(
          onPressed: null,
          child: const Text(
            'Skip',
            style: FitnessAppTheme.skip_intro,
          ),
          style: skipButtonStyle,
        ),
        //-->> Dots
        dotsDecorator: dotsDecorator,
        dotsFlex: 2,
        //-->> Done button
        showDoneButton: true,
        doneColor: FitnessAppTheme.white,
        done: ElevatedButton(
          onPressed: null,
          child: const Text(
            'Go',
            style: FitnessAppTheme.Go,
          ),
          style: nextButtonStyle,
        ),
        //-->> General configurations
        animationDuration: 600,
        onDone: () => Navigator.pushNamed(context, '/goal'),
      ),
    );
  }

  Widget buildImage(String path, double height) {
    return Center(
      child: Image.asset(
        path,
        height: height,
      ),
    );
  }

  final PageDecoration pageDecoration = const PageDecoration(
    pageColor: Colors.white,
    imageFlex: 2,
    imagePadding: EdgeInsets.fromLTRB(0, 80, 0, 0),
    titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    descriptionPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    bodyFlex: 1,
    contentMargin: EdgeInsets.all(16),
    titleTextStyle: FitnessAppTheme.page_title,
    bodyTextStyle: FitnessAppTheme.page_body,
  );

  final DotsDecorator dotsDecorator = const DotsDecorator(
    color: Colors.grey,
    shape: CircleBorder(),
    activeColor: Colors.lightBlue,
    activeShape: CircleBorder(),
    size: Size(10, 10),
    activeSize: Size(16, 16),
    spacing: EdgeInsets.all(6),
  );

  final ButtonStyle nextButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(const CircleBorder()),
    backgroundColor:
        MaterialStateProperty.all(FitnessAppTheme.selectorGrayBackGround),
    fixedSize: MaterialStateProperty.all(const Size(60, 60)),
    elevation: MaterialStateProperty.all(6),
    shadowColor: MaterialStateProperty.all(Colors.lightBlue),
    side: MaterialStateProperty.all(
        const BorderSide(color: Colors.lightBlue, width: 2)),
  );

  final ButtonStyle skipButtonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all(FitnessAppTheme.selectorGrayBackGround),
    fixedSize: MaterialStateProperty.all(const Size(160, 45)),
    elevation: MaterialStateProperty.all(6),
    shadowColor: MaterialStateProperty.all(Colors.lightBlue),
    side: MaterialStateProperty.all(
        const BorderSide(color: Colors.lightBlue, width: 2)),
  );
}
