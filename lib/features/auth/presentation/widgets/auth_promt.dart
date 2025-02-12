import 'package:chat_app/core/theme.dart';
import 'package:flutter/material.dart';

class AuthPromt extends StatelessWidget {
  final String textGrey;
  final String textBlue;
  final VoidCallback onTap;

  const AuthPromt({
    super.key,
    required this.textGrey,
    required this.textBlue,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: textGrey,
            style: TextStyle(
              color: DefaultColors.greyText,
            ),
            children: [
              TextSpan(
                text: textBlue,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}