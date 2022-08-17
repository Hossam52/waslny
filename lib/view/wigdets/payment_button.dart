import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final VoidCallback ontap;
  final String buttonText;
  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  final double? wdithSize;

  const PaymentButton({
    Key? key,
    required this.ontap,
    required this.buttonText,
    required this.textColor,
    required this.borderColor,
    required this.backgroundColor,
    this.wdithSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wdithSize,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
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
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
