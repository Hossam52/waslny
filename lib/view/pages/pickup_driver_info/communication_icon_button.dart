import 'package:flutter/material.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/value_manager.dart';

class CommunicationIconButton extends StatelessWidget {
  final VoidCallback ontap;
  final IconData icon;

  const CommunicationIconButton(
      {Key? key, required this.icon, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorManager.offWhite,
        boxShadow: const [
          BoxShadow(
            color: ColorManager.gray,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: ontap,
      ),
    );
  }
}
