import 'package:flutter/material.dart';

class ResultScreenQuiz extends StatefulWidget {
  final int? correct;
  final int? total;
  final int? index;
  final int? time;
  final List<bool?>? resultUserAnswer;
  final List<bool>? resultQuestionOfAnswer;

  const ResultScreenQuiz({
    super.key,
    this.correct,
    this.total,
    this.index,
    this.time,
    this.resultUserAnswer,
    this.resultQuestionOfAnswer,
  });

  @override
  State<ResultScreenQuiz> createState() => _ResultScreenQuizState();
}

class _ResultScreenQuizState extends State<ResultScreenQuiz> {
  String statusText = '';
  String mainMessage = '';
  String subMessage = '';
  double percentage = 0;
  Color? resultColor;
  Color? containerColorGreen;
  Color? containerColorRed;
  int anaIndex = 0;

  // void _questionAnalysis() {
  //   if () {
  //     containerColorGreen = Colors.green;
  //     anaIndex++;
  //   } else {
  //     containerColorRed = Colors.red;
  //     anaIndex++;
  //   }
  // }

  void _statusCheck() {
    switch (percentage) {
      case 100:
        statusText = '🏆 Passed';
        mainMessage = 'Great Job!';
        subMessage = 'Perfect Score!';
        resultColor = Colors.green;
        break;
      case 80:
        statusText = '🏆 Passed!';
        mainMessage = 'Great Job!';
        subMessage = 'Amazing Job!';
        resultColor = Colors.green;
        break;

      case 60:
        statusText = '☹️ Not passed!';
        mainMessage = 'Keep practicing!';
        subMessage = 'Great Progress!';
        resultColor = Color.fromARGB(255, 248, 145, 145);

        break;

      case 40:
        statusText = '☹️ Not passed!';
        mainMessage = 'Keep practicing!';
        subMessage = ' Halfway There!';
        resultColor = Color.fromARGB(255, 248, 145, 145);
        break;

      case 20:
        statusText = '☹️ Not passed!';
        mainMessage = 'Keep practicing!';
        subMessage = 'Good Start!';
        resultColor = Color.fromARGB(255, 248, 145, 145);
        break;

      case 0:
        statusText = '☹️ Not passed!';
        mainMessage = 'Keep practicing!';
        subMessage = 'Keep Trying!';
        resultColor = Color.fromARGB(255, 248, 145, 145);
        break;
      default:
        debugPrint('Invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeightQuiz = MediaQuery.of(context).size.height;
    double screenWidthQuiz = MediaQuery.of(context).size.width;
    percentage = ((widget.correct ?? 0) / (widget.total ?? 1)) * 100;
    _statusCheck();
    // _questionAnalysis();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1E2235),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Your Performance",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5B3A3E), Color(0xFF1E2235)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: screenHeightQuiz * 0.400,
                width: double.infinity,
                color: Color(0xFF232A3D),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: screenWidthQuiz * 0.30,
                            width: screenWidthQuiz * 0.30,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFEF6C6C).withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${percentage.toStringAsFixed(1)}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: screenHeightQuiz * 0.042,
                                width: screenWidthQuiz * 0.33,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 77, 56, 60),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    statusText,
                                    style: TextStyle(
                                      color: resultColor,
                                      fontSize: screenHeightQuiz * 0.017,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),
                              Text(
                                mainMessage,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenHeightQuiz * 0.024,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                subMessage,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenHeightQuiz * 0.016,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidthQuiz * 0.035,
                          right: screenWidthQuiz * 0.035,
                          top: screenHeightQuiz * 0.040,
                        ),
                        child: Divider(
                          color: Color(0xFF2A2F45),
                          thickness: 1.5,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 80,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF2E7D32,
                                        ).withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: screenHeightQuiz * 0.002,
                                      ),
                                      child: Text(
                                        '${(widget.correct)}/${widget.total}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Correct',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenHeightQuiz * 0.015,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    color: Color(0xFF2A2F45),
                                    thickness: 1.5,
                                    width: 20,
                                  ),
                                ),

                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF1565C0,
                                        ).withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.access_time,
                                          color: Color(0xFF1565C0),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: screenHeightQuiz * 0.002,
                                      ),
                                      child: Text(
                                        '${((widget.time ?? 0) ~/ 60).toString().padLeft(2, '0')}:${((widget.time) ?? 0 % 60).toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenHeightQuiz * 0.015,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    color: Color(0xFF2A2F45),
                                    thickness: 1.5,
                                    width: 20,
                                  ),
                                ),

                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFFF57C00,
                                        ).withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.refresh,
                                          color: Color(0xFFF57C00), //
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: screenHeightQuiz * 0.002,
                                      ),
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Repeated',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenHeightQuiz * 0.015,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeightQuiz * 0.18,
            left: screenWidthQuiz * 0.050,
            right: screenWidthQuiz * 0.050,

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF232A3D),
              ),
              height: screenHeightQuiz * 0.200,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF6C63FF).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.analytics,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Question Analysis',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeightQuiz * 0.025,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        for (
                          int i = 0;
                          i < widget.resultQuestionOfAnswer!.length;
                          i++
                        ) ...[
                          Container(
                            decoration: BoxDecoration(
                              color: widget.resultUserAnswer![i] == true
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                          // 👉 HAR container ke baad gap
                          if (i != widget.resultQuestionOfAnswer!.length - 1)
                            SizedBox(width: 10),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: screenHeightQuiz * 0.030,
            left: screenWidthQuiz * 0.050,
            right: screenWidthQuiz * 0.050,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: screenHeightQuiz * 0.070,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF7A7A), Color(0xFFFF5E5E)],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Retry Quiz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidthQuiz * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
