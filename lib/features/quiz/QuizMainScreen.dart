import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 44),
          const Text(
            'Quiz',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'SFB',
            ),
          ),
          const Text(
            '5 themes',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          // Кнопки для каждой темы викторины
          _buildQuizCategoryButton(
            context,
            'Currencies',
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildQuizCategoryButton(
            context,
            'Stocks',
            Colors.green,
          ),
          const SizedBox(height: 16),
          _buildQuizCategoryButton(
            context,
            'Bonds',
            Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildQuizCategoryButton(
            context,
            'Derivatives',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCategoryButton(
      BuildContext context, String theme, Color color) {
    return ElevatedButton(
      onPressed: () => _startQuiz(context, theme),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        theme,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  void _startQuiz(BuildContext context, String theme) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(theme: theme),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String theme;
  const QuizScreen({required this.theme, Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  late List<QuizQuestion> questions;
  int score = 0;

  @override
  void initState() {
    super.initState();
    questions = quizData[widget.theme]!;
  }

  void _selectAnswer(int selectedIndex) {
    setState(() {
      if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
        score++;
      }
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showQuizResult();
      }
    });
  }

  void _showQuizResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quiz Complete"),
          content: Text("You scored $score out of ${questions.length}!"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Возвращаемся на главный экран
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.theme} Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              currentQuestion.question,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => _selectAnswer(index),
                      child: Text(
                        currentQuestion.options[index],
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

final Map<String, List<QuizQuestion>> quizData = {
  'Currencies': [
    QuizQuestion(
      question: 'What is the currency of Japan?',
      options: ['Yuan', 'Won', 'Yen', 'Ringgit'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What currency is used in Switzerland?',
      options: ['Euro', 'Krone', 'Dollar', 'Swiss Franc'],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      question: 'Which country uses the Peso?',
      options: ['China', 'Russia', 'India', 'Argentina'],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      question: 'What is the currency of Brazil?',
      options: ['Real', 'Peso', 'Lira', 'Dollar'],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'Which currency is used in Russia?',
      options: ['Euro', 'Dollar', 'Ruble', 'Yen'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What is the currency of South Korea?',
      options: ['Won', 'Yuan', 'Ringgit', 'Baht'],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'The Euro is the official currency of how many countries?',
      options: ['28', '10', '19', '23'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What is the currency of India?',
      options: ['Yen', 'Rupee', 'Rial', 'Dirham'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'Which country uses the Rand as its currency?',
      options: ['Mexico', 'New Zealand', 'South Africa', 'Norway'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Which country uses the Dirham as its currency?',
      options: ['Japan', 'UAE', 'Egypt', 'Russia'],
      correctAnswerIndex: 1,
    ),
  ],
  'Stocks': [
    QuizQuestion(
      question: 'What does P/E ratio stand for in stock valuation?',
      options: [
        'Profit and Expense',
        'Price to Earnings',
        'Public Equity',
        'Performance Evaluation'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question:
          'Which stock market index tracks 30 large companies in the U.S.?',
      options: ['Nasdaq', 'Dow Jones', 'FTSE 100', 'S&P 500'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'What is an IPO?',
      options: [
        'Initial Private Offering',
        'Investment Portfolio Option',
        'Initial Public Offering',
        'International Purchase Option'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What does a bull market indicate?',
      options: [
        'Rising Prices',
        'Falling Prices',
        'Stagnant Market',
        'Volatile Market'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'Which stock market is the largest by market capitalization?',
      options: [
        'Tokyo Stock Exchange',
        'Shanghai Stock Exchange',
        'NASDAQ',
        'New York Stock Exchange'
      ],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      question: 'What does dividend yield measure?',
      options: [
        'Stock Price Increase',
        'Annual Dividend Return',
        'Market Share',
        'Total Revenue'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'What is the primary goal of a stock split?',
      options: [
        'Increase Stock Price',
        'Decrease Stock Price',
        'Increase Liquidity',
        'Pay Dividends'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question:
          'Which of these is a stock market term for significant price drops?',
      options: ['Bear Market', 'Bull Market', 'Black Market', 'Golden Cross'],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'What does the S&P 500 index measure?',
      options: [
        '500 Small Cap Stocks',
        'Top 500 Tech Companies',
        '500 Largest U.S. Companies',
        '500 Global Companies'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Which organization regulates the U.S. stock market?',
      options: ['IMF', 'Federal Reserve', 'SEC', 'World Bank'],
      correctAnswerIndex: 2,
    ),
  ],
  'Bonds': [
    QuizQuestion(
      question: 'What type of bond is considered the safest?',
      options: [
        'Corporate Bonds',
        'Municipal Bonds',
        'Junk Bonds',
        'Government Bonds'
      ],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      question: 'What is a bond?',
      options: [
        'A loan made by an investor to a borrower',
        'A share of a company',
        'A physical asset',
        'A financial derivative'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'What does the yield of a bond represent?',
      options: [
        'The interest rate it pays',
        'The bond’s market value',
        'The maturity date',
        'The issuer of the bond'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'What is a municipal bond?',
      options: [
        'A bond issued by a local government',
        'A corporate bond',
        'An international bond',
        'A high-risk bond'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'Which bond type pays interest based on inflation?',
      options: [
        'Fixed-rate bonds',
        'Treasury Inflation-Protected Securities (TIPS)',
        'Zero-coupon bonds',
        'Convertible bonds'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'What happens when a bond reaches maturity?',
      options: [
        'It stops paying interest',
        'It doubles in value',
        'The principal is repaid to the bondholder',
        'The bond is converted to stock'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Which rating indicates a higher risk bond?',
      options: ['AAA', 'BB', 'CCC', 'A'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What is a coupon in bond terms?',
      options: [
        'The interest paid by the bond',
        'The maturity date of the bond',
        'The bond’s yield',
        'The issuer’s guarantee'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question:
          'Which type of bond offers the highest risk and potential return?',
      options: [
        'Government Bonds',
        'Municipal Bonds',
        'Junk Bonds',
        'Savings Bonds'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Which type of bond has no periodic interest payments?',
      options: [
        'Fixed-rate Bonds',
        'Zero-coupon Bonds',
        'Municipal Bonds',
        'Corporate Bonds'
      ],
      correctAnswerIndex: 1,
    ),
  ],
  'Derivatives': [
    QuizQuestion(
      question: 'Which of the following is not a type of derivative?',
      options: ['Futures', 'Options', 'Swaps', 'Dividends'],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      question: 'What is a futures contract?',
      options: [
        'A contract to buy or sell an asset at a future date',
        'A bond issued by the government',
        'A type of stock',
        'A loan with a fixed interest rate'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'What is an option in derivative trading?',
      options: [
        'A stock that provides dividends',
        'A contract to buy or sell at a specific price',
        'A bond that changes value',
        'A physical commodity'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'Which market do derivatives primarily trade on?',
      options: [
        'Stock Market',
        'Commodities Market',
        'Derivative Market',
        'Forex Market'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What does leverage mean in derivatives trading?',
      options: [
        'Borrowing money to increase potential returns',
        'Hedging risk with options',
        'Selling stock at a loss',
        'Issuing corporate bonds'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the main purpose of hedging with derivatives?',
      options: [
        'Increase returns',
        'Maximize liquidity',
        'Minimize risk',
        'Diversify portfolio'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What is a swap in finance?',
      options: [
        'Exchanging one bond for another',
        'A contract to exchange cash flows',
        'Selling stock at market price',
        'A loan with a floating interest rate'
      ],
      correctAnswerIndex: 1,
    ),
  ],
};
