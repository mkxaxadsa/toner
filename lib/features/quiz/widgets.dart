import 'dart:io';

import 'package:finance_app/features/quiz/QuizQuestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dars.dart';
import 'quizs.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
    required this.onDelete,
  });

  final Comment comment;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: 302,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 302,
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  comment.by,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF',
                  ),
                ),
                const Spacer(),
                Text(
                  comment.date,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF',
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onLongPress: comment.current ? onDelete : null,
            child: Container(
              width: 262,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                comment.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.quiz});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 217, 215, 215),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CupertinoButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizCommentsPage(
                quiz: quiz,
              ),
            ),
          );
        },
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'By ${quiz.by}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF',
                  ),
                ),
                const Spacer(),
                Text(
                  quiz.date,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              quiz.question,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontFamily: 'SF',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 222, 222, 222),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CupertinoButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuizQuestionsPage()),
          );
        },
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            const Text(
              'Possible improvements or modifications',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 21,
                fontFamily: 'SF',
              ),
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Text(
                  'April 1, 2024',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 15,
                    fontFamily: 'SF',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                SizedBox(
                  height: 44,
                  width: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8,
                        top: 5,
                        child: Text(
                          '${quizesListModel.length} questions',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
