import 'package:hive_flutter/hive_flutter.dart';

class Quiz {
  final int id;
  final String by;
  final String date;
  final String question;
  List<Comment> comments;

  Quiz({
    required this.id,
    required this.by,
    required this.date,
    required this.question,
    required this.comments,
  });
}

@HiveType(typeId: 1)
class Comment {
  @HiveField(0)
  final int quizID;
  @HiveField(1)
  final String by;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final bool current;

  Comment({
    required this.quizID,
    required this.by,
    required this.date,
    required this.title,
    required this.current,
  });
}

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final typeId = 1;

  @override
  Comment read(BinaryReader reader) {
    return Comment(
      quizID: reader.read(),
      by: reader.read(),
      date: reader.read(),
      title: reader.read(),
      current: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer.write(obj.quizID);
    writer.write(obj.by);
    writer.write(obj.date);
    writer.write(obj.title);
    writer.write(obj.current);
  }
}

List<Quiz> quizesListModel = [
  Quiz(
    id: 1,
    by: 'Liam Wilson',
    date: 'June 1, 2024',
    question:
        'What additional integrations would you like to see in the app to enhance its functionality?',
    comments: [],
  ),
  Quiz(
    id: 2,
    by: 'Isabella Miller',
    date: 'June 4, 2024',
    question: 'What do you like the most about the app’s user interface?',
    comments: [],
  ),
  Quiz(
    id: 3,
    by: 'Noah Brown',
    date: 'June 10, 2024',
    question:
        'Which types of notifications in the app do you find most useful?',
    comments: [],
  ),
  Quiz(
    id: 4,
    by: 'Sophia Johnson',
    date: 'June 15, 2024',
    question: 'Are there any features that you find unnecessary or rarely use?',
    comments: [],
  ),
  Quiz(
    id: 5,
    by: 'Lucas Garcia',
    date: 'June 20, 2024',
    question:
        'How would you rate the quality of customer support within the app?',
    comments: [],
  ),
  Quiz(
    id: 6,
    by: 'Mia Martinez',
    date: 'June 28, 2024',
    question: 'How responsive is the app when performing various tasks?',
    comments: [],
  ),
  Quiz(
    id: 7,
    by: 'James Rodriguez',
    date: 'July 5, 2024',
    question: 'What features would you like to see to improve data security?',
    comments: [],
  ),
  Quiz(
    id: 8,
    by: 'Amelia Davis',
    date: 'July 12, 2024',
    question:
        'What functionality do you think should be added in the next updates?',
    comments: [],
  ),
  Quiz(
    id: 9,
    by: 'Benjamin Martinez',
    date: 'July 20, 2024',
    question: 'What do you like about the app’s visual design?',
    comments: [],
  ),
  Quiz(
    id: 10,
    by: 'Emma Anderson',
    date: 'August 1, 2024',
    question: 'What aspects of the app need improvement in terms of usability?',
    comments: [],
  ),
  Quiz(
    id: 11,
    by: 'Oliver White',
    date: 'August 10, 2024',
    question: 'How does the app’s performance impact your overall experience?',
    comments: [],
  ),
  Quiz(
    id: 12,
    by: 'Ava Thompson',
    date: 'August 25, 2024',
    question:
        'What new features would enhance your overall experience with the app?',
    comments: [],
  ),
];

List<Comment> commentsListModel = [
  Comment(
    quizID: 1,
    by: 'Charlotte Johnson',
    date: 'June 2, 2024',
    title:
        'Integration with banking systems would be very useful for tracking transactions.',
    current: false,
  ),
  Comment(
    quizID: 1,
    by: 'William Wright',
    date: 'June 3, 2024',
    title:
        'I would love to see integration with cloud services for data synchronization.',
    current: false,
  ),
  Comment(
    quizID: 2,
    by: 'Olivia Brown',
    date: 'June 5, 2024',
    title:
        'I like the simplicity of the interface and the logical structure of sections.',
    current: false,
  ),
  Comment(
    quizID: 3,
    by: 'Lucas Davis',
    date: 'June 11, 2024',
    title: 'I find notifications about important events very helpful.',
    current: false,
  ),
  Comment(
    quizID: 3,
    by: 'Sophia Lopez',
    date: 'June 12, 2024',
    title:
        'Sometimes, notifications come too frequently and become distracting.',
    current: false,
  ),
  Comment(
    quizID: 4,
    by: 'Mason Gonzalez',
    date: 'June 16, 2024',
    title: 'The expense forecasting feature seems unnecessary to me.',
    current: false,
  ),
  Comment(
    quizID: 5,
    by: 'Isabella Wilson',
    date: 'June 21, 2024',
    title: 'Customer support always responds quickly, and I get useful advice.',
    current: false,
  ),
  Comment(
    quizID: 6,
    by: 'Liam Martinez',
    date: 'June 29, 2024',
    title:
        'The app runs smoothly, but sometimes lags when working with large reports.',
    current: false,
  ),
];
