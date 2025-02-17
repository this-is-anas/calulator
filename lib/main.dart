import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var userQuestions = 'Questions';
  var userAnswers = 'Answers';


  final List<String> buttons =
  [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestions,style: TextStyle(fontSize: 20),)),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userAnswers,style: TextStyle(fontSize: 20),)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index){
                    //clear button
                    if(index == 0){
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            userQuestions = '';
                            userAnswers = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                      //del button
                    }else if(index == 1){
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            userQuestions = userQuestions.substring(0,userQuestions.length-1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,);
                    }
                    //= button
                    else if(index == buttons.length-1){
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue,
                        textColor: Colors.white,);
                    }
                    else{
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            userQuestions += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index]) ? Colors.blue : Colors.white,
                        textColor: isOperator(buttons[index]) ? Colors.white : Colors.blue,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x){
    if(x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=' ){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion = userQuestions;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswers = eval.toString();
  }
}
