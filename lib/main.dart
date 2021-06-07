import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  List<Icon> scoreKeeper = [];
  var questionNum = 0;
  List<String> questionBank = [
    'Are you in love with me?',
    'Will you marry me',
    'Again some yes no question'
  ];

  void questionFunction() {
    if (questionNum == 2) {
      questionNum = 0;
    } else
      questionNum += 1;
  }

  layout(height, width) {
    if (height > width) {
      return _buildOneColumnView();
    } else {
      return _buildTwoColumnView();
    }
  }

  Widget _buildTwoColumnView() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Container(
                      width: 350,
                      child: Text(
                        questionBank[questionNum],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: FlatButton(
                    height: 60,
                    minWidth: 185,
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        controll.jumpTo(
                          controll.position.maxScrollExtent,
                        );
                        questionFunction();
                        scoreKeeper.add(
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        );
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: FlatButton(
                    height: 60,
                    minWidth: 185,
                    color: Colors.red,
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        controll.jumpTo(
                          controll.position.maxScrollExtent,
                        );
                        questionFunction();
                        scoreKeeper.add(
                          Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        );
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: SingleChildScrollView(
                    controller: controll,
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      children: scoreKeeper,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOneColumnView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[questionNum],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  controll.jumpTo(
                    controll.position.maxScrollExtent,
                  );
                  questionFunction();
                  scoreKeeper.add(
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  );
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  controll.jumpTo(
                    controll.position.maxScrollExtent,
                  );
                  questionFunction();
                  scoreKeeper.add(
                    Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  );
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          child: SingleChildScrollView(
            controller: controll,
            scrollDirection: Axis.vertical,
            child: Wrap(
              children: scoreKeeper,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  final controll = ScrollController();

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return layout(height, width);
  }
}
