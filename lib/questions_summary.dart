import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  // wehave to accept the summary map in here to be processes.
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2)),
      child: SizedBox(
        //creating abox with fixed height then we later scroll
        height: 300,
        child: SingleChildScrollView(
          // makes child scrollable, if size offered excedes then scroll
          child: Column(
            // STRUCTURE.
            //Major Column -> Question Number Row -> Question briefing column
            children:
                // Normally we would require a list but now we can use the pre existing summary data
                summaryData.map((data) {
                  return Row(
                    children: [
                      Text(
                        ((data['question_index'] as int) + 1).toString(),
                      ), // we use the key to access the value, type casting when you know the actual value type in map but dart throws errors. and we derive the final answer to string.
                      Expanded(
                        //making a child take more space but not overeat it's flex parent widget, or else these child ignores the size of the parent.
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                data['question'] as String,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 15),
                              Text(data['user_answer'] as String),
                              Text(data['correct_answer'] as String),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ); // we convert the map iterable to list to remove the error
                }).toList(),
          ),
        ),
      ),
    );
  }
}
