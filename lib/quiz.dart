import 'package:adv_basics/data/qustions.dart';
import 'package:adv_basics/question_screen.dart';
import 'package:adv_basics/results_screen.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswer = [];
  var activeScreen = "start-screen";

  //sets screen firstly, if not it would set the screen the same time the function would be mutating the object
  // the object is created, sets the screeen, the function waits for it's call.
  // to avoid variable and function initialisation at the same time so we make one run before the other.
  // It doesnt know if the method exists yet

  void switchScreen() {
    setState(() {
      activeScreen = "question-screen";
    });
  }

  void restartButton() {
    setState(() {
      activeScreen = "start-screen";
      selectedAnswer = [];
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = "result-screen";
      });
    }
  }

  @override
  Widget build(context) {
    Widget? screenWidget;

    if (activeScreen == "question-screen") {
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == "result-screen") {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswer,
        restartQuiz: restartButton,
        // So onclick we pass the restart button function to update the activescreen to startscreen
      );
    }

    if (activeScreen == "start-screen") {
      screenWidget = StartScreen(switchScreen);
      // So onclick we pass the restart button function to update the activescreen to startscreen
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 76, 5, 175),
                Color.fromARGB(255, 189, 21, 223),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
        // after the second option is the choice the choose answer function will be forwaded to the QS class
      ),
    );
  }
}
