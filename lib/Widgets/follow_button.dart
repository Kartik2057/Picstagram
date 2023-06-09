import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String text;

  const FollowButton({
    super.key,
    this.function,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    }
    );

  @override
  Widget build(BuildContext context) {
    print("in follow button : $text");
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 250,
          height: 27,
          child: Text(text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold
          ),
          ),
        ),
        ),
    );
  }
}