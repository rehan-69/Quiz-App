import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'dart:async';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int seconds = 0;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  List<String> question = [
    'Can we assign int to double explicitly ?',
    'GestureDetector and Inkwell are same ?',
    'Dart supports multi-level inheritance ?',
    'Dart supports any class to be used as mixin',
    'Sealed classes are by default abstract',
  ];
  List<bool> questionOfAnswer = [true, false, false, false, true];
  List<Widget> scoreTracker = [];
  bool userOfAnswer = false;
  int currentQuestionIndex = 0;
  int totalCorrectAnswer = 0;
  int totalWrongAnswer = 0;
  List<bool?> storeUserOfAnswer = [];
  @override
  void initState() {
    super.initState();
    startTimer();

    storeUserOfAnswer = List.filled(question.length, null);
  }

  final player = AudioPlayer();
  Future<void> playCorrectSound() async {
    await player.play(AssetSource('right_answer.mp3'));
  }

  Future<void> playWrongSound() async {
    await player.play(AssetSource('wrong_answer.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E1E1E),
        title: Text(
          'Quizler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(backgroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} / ${question.length}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.020,
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 3.5,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation(Color(0xFF6C63FF)),

                  value: (currentQuestionIndex + 1) / question.length,
                ),
              ),
            ),

            SizedBox(height: 15),

            Container(
              height: screenHeight * 0.25,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),

              child: Card(
                color: Color(0xFF242424),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Center(
                  child: Text(
                    question[currentQuestionIndex],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.019,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF00C853),
                  ),
                  onPressed: () {
                    if (scoreTracker.length < question.length) {
                      if (questionOfAnswer[currentQuestionIndex] == true) {
                        scoreTracker.add(
                          Icon(
                            Icons.check,
                            color: Color(0xFF00C853),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                        playCorrectSound();
                      } else {
                        scoreTracker.add(
                          Icon(
                            Icons.close,
                            color: Color(0xFFD50000),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                        playWrongSound();
                      }
                    }
                    userOfAnswer = true;

                    bool isCorrect =
                        userOfAnswer == questionOfAnswer[currentQuestionIndex];

                    storeUserOfAnswer[currentQuestionIndex] = isCorrect;

                    if (isCorrect) {
                      totalCorrectAnswer++;
                    } else {
                      totalWrongAnswer++;
                    }

                    if (currentQuestionIndex == question.length - 1) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ResultScreenQuiz(
                                    correct: totalCorrectAnswer,
                                    total: question.length,
                                    index: currentQuestionIndex,
                                    time: seconds,
                                    resultUserAnswer: storeUserOfAnswer,
                                    resultQuestionOfAnswer: questionOfAnswer,
                                  ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),
                      );
                    } else {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    }
                  },
                  label: Text(
                    'True',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(Icons.check, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 2),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFD50000),
                  ),
                  onPressed: () {
                    if (scoreTracker.length < question.length) {
                      if (questionOfAnswer[currentQuestionIndex] == false) {
                        scoreTracker.add(
                          Icon(
                            Icons.check,
                            color: Color(0xFF00C853),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                        playCorrectSound();
                      } else {
                        scoreTracker.add(
                          Icon(
                            Icons.close,
                            color: Color(0xFFD50000),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                        playWrongSound();
                      }
                    }
                    userOfAnswer = false;
                    bool isCorrect =
                        userOfAnswer == questionOfAnswer[currentQuestionIndex];

                    storeUserOfAnswer[currentQuestionIndex] = isCorrect;

                    if (isCorrect) {
                      totalCorrectAnswer++;
                    } else {
                      totalWrongAnswer++;
                    }
                    if (currentQuestionIndex == question.length - 1) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ResultScreenQuiz(
                                    correct: totalCorrectAnswer,
                                    total: question.length,
                                    index: currentQuestionIndex,
                                    time: seconds,
                                    resultUserAnswer: storeUserOfAnswer,
                                    resultQuestionOfAnswer: questionOfAnswer,
                                  ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),
                      );
                    } else {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    }
                  },
                  label: Text(
                    'False',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(Icons.close, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: scoreTracker,
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF2C2C2C),
                    side: BorderSide(color: Color(0xFF4A3FCF)),
                  ),
                  onPressed: () {
                    currentQuestionIndex = 0;
                    totalCorrectAnswer = 0;
                    totalWrongAnswer = 0;
                    seconds = 0;
                    scoreTracker.clear();
                    setState(() {});
                  },
                  child: Text(
                    'Reset Quiz',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
