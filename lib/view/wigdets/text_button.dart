import 'package:flutter/material.dart';

class DefualtTextButton extends StatelessWidget {
  final VoidCallback ontap;
  final String buttonText;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final double? widthSize;

  const DefualtTextButton({
    Key? key,
    required this.ontap,
    required this.buttonText,
    required this.borderColor,
    required this.textColor,
    required this.backgroundColor,
    this.widthSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthSize ?? double.infinity,
      // margin: const EdgeInsets.all(10),
      height: 55.0,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: borderColor,
          ),
        ),
        onPressed: ontap,
        color: backgroundColor,
        textColor: textColor,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
