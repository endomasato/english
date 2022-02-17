import 'package:audioplayers/audioplayers.dart';
import 'package:english/questions.dart';
import 'package:flutter/material.dart';
import 'dart:math';



class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {


  int questionNumber() {
    final random = new Random();
    int number = random.nextInt(questions.length);
    return number;
  }
 late String yourAnswer;
  

  final _pageController = PageController();

  // void nextQuestion() {
  //   setState(() async{
  //     await questions[questionNumber()];
  //   });
  // }


  Widget buildStatus() {
    switch(_quizstatus) {
      case Quizstatus.before:
        return Container();
        break;
      case Quizstatus.correct:
        return Center(
          child: Icon(Icons.circle_outlined,size: 300,color: Colors.red,),
        );
        break;
      case Quizstatus.incorrect:
        return Column(
          children: [
            Center(
              child: Icon(Icons.clear,size: 300,color: Colors.black,),
            ),
            Text('正解は$answers[0]',style: TextStyle(fontSize: 50),)
          ],
        );
        break;
      default: return Container();
    }
  }

  Quizstatus _quizstatus = Quizstatus.before;

  final _audio = AudioCache();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
              children: [Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(child: Text('Question',style: TextStyle(fontSize: 30),)),
                  ),
                  Center(child: Text(questions[questionNumber()],style: TextStyle(fontSize: 50),)),
                  Container(
                    width: 400,
                    height: 60,
                    child: TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      onChanged: (value){
                        yourAnswer = value;
                      },
                    ),
                  ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                        onPressed: () async{
                          if(yourAnswer == answers[questionNumber()]) {
                            _quizstatus = Quizstatus.correct;
                            _audio.play('correct.mp3');
                          }else{
                            _quizstatus = Quizstatus.incorrect;
                            _audio.play('wrong.mp3');
                          }
                          setState(() {

                          }
                          );

                          await Future.delayed(Duration(seconds: 3));
                          // _quizstatus = Quizstatus.before;
                          await _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage()));

                        },
                            child: Text('Answer',style: TextStyle(fontSize: 30)),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                )

                            )),
                      ),

                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);

                    },

                        child: Text('Backl',style: TextStyle(fontSize: 30)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            )

                        )),
                  )],
          ),
              ],
            ),
            buildStatus()
        ])
        ));

  }
}


enum Quizstatus {
  before,
  correct,
  incorrect

}

