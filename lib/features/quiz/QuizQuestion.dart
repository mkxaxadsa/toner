import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dars.dart';
import 'widgets.dart';

class QuizQuestionsPage extends StatelessWidget {
  const QuizQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 98),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Possible improvements or modifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFB',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Text(
                        '10 Questions',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'SFM',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    quizesListModel.length,
                    (index) {
                      return QuestionCard(quiz: quizesListModel[index]);
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
