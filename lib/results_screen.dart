import 'package:adv_basics/data/qustions.dart';
import 'package:adv_basics/questions_summary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz,
  });

  final List<String> chosenAnswers;

  final void Function() restartQuiz;

  // we needed a key value pair string as key and object as value to store multiple data,
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      //To in the end we hold a summary list containing all information to display on the final page
      summary.add({
        'question_index': i,
        'question':
            questions[i]
                .text, // importing from question file, use indexer i to reflect the question index
        'correct_answer': questions[i].answers[0],
        'user_answer':
            chosenAnswers[i], // tracks the use ansewer with the question index
      }); // Creating map in the list data type cause it was expecting it,
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData =
        getSummaryData(); // calling the functioon will necessary information into a variable
    final numTotalQuestions = questions.length;
    final numCorrectQuestions =
        summaryData.where(
          (data) {
            return data['user_answer'] == data['correct_answer'];
          },
        ).length; // to find answers equals to real answers,evaluates which values remain or kept.

    return SizedBox(
      width: double.infinity,

      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
            ),
            SizedBox(height: 30),
            Center(child: QuestionsSummary(summaryData)),
            const SizedBox(height: 30),
            TextButton(onPressed: restartQuiz, child: Text("Restart Quiz")),
          ],
        ),
      ),
    );
  }
}
