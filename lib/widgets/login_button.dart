import 'package:flutter/material.dart';
import 'package:note_it/config/size_config.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            width(32), height(13), width(18.25), height(17)),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.deepPurple.shade300, // Set border color
              width: 1.0),
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(21),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
