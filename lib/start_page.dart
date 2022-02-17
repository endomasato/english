import 'package:english/question_page.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('English App'),
        ),
        body: SafeArea(
          child: StartPage(),
        ),
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Let''s try.',style: TextStyle(fontSize: 50),),
            ),
            SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async{
                    await _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage()));

                  },
                  child: Text('START',style: TextStyle(fontSize: 30)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),
              ),
          ],
        ),
        ),
    ]);
  }
}
