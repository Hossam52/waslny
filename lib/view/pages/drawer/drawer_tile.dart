import 'package:flutter/material.dart';
import 'package:user_app/utils/color_manager.dart';

class DrawerTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPress;
  const DrawerTile({
    Key? key,
    required this.text,
    required this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Icon(
        icon,
        color: ColorManager.black,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
