import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButtons({this.color, required this.buttonText, this.textColor, this.buttonTapped});

  // const Buttons({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
