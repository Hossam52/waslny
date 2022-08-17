import 'package:flutter/material.dart';

class TripIconButton extends StatelessWidget {
  final VoidCallback ontap;
  final String buttonText;
  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  final double? wdithSize;
  final IconData icon;

  const TripIconButton({
    Key? key,
    required this.ontap,
    required this.buttonText,
    required this.textColor,
    required this.borderColor,
    required this.backgroundColor,
    this.wdithSize,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wdithSize,
      // margin: const EdgeInsets.all(10),
      // height: 55.0,
      child: MaterialButton(
        elevation: 0,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(
            color: borderColor,
          ),
        ),
        onPressed: ontap,
        color: backgroundColor,
        textColor: textColor,
        child: Column(
          children: [
            Icon(icon),
            Text(
              buttonText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
