import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final String content;

  const CustomText({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            height: 50,
            width: 100,
            child: Text(title),

          ),
          const VerticalDivider(
            width: 50,
          ),
          Container(
            height: 50,
            width: 100,
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
