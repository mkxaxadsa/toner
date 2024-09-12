import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dars.dart';
import 'widgets.dart';

class QuizCommentsPage extends StatefulWidget {
  const QuizCommentsPage({super.key, required this.quiz});

  final Quiz quiz;

  @override
  State<QuizCommentsPage> createState() => _QuizCommentsPageState();
}

class _QuizCommentsPageState extends State<QuizCommentsPage> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 98),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
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
            ),
            const SizedBox(height: 28),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                controller: scrollController,
                children: [
                  const SizedBox(height: 16),
                  _QuestionCard(quiz: widget.quiz),
                  const SizedBox(height: 16),
                  const SizedBox(
                    height: 80,
                  ),
                  ...List.generate(
                    widget.quiz.comments.length,
                    (index) {
                      return CommentCard(
                        comment: widget.quiz.comments[index],
                        onDelete: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.quiz});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 226, 226),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
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
    );
  }
}

class _MessageField extends StatelessWidget {
  const _MessageField({
    required this.controller,
    required this.onSend,
    required this.onTap,
  });

  final TextEditingController controller;
  final void Function() onSend;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),
      height: 87,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF',
                ),
                decoration: const InputDecoration(
                  hintText: 'Message',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                onTap: onTap,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
