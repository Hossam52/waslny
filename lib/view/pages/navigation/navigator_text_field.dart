import 'dart:developer';

import 'package:flutter/material.dart';

class NavigatorTextFeild extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final String? Function(String?)? validate;
  final String? label;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? suffixpressed;
  final Function(String)? onChange;

  final Function(String?)? onSubmite;
  final bool? isvisiable;
  final Color? iconColor;
  final FocusNode? focusNode;

  const NavigatorTextFeild({
    Key? key,
    this.controller,
    this.type,
    this.validate,
    this.label,
    this.prefix,
    this.suffix,
    this.suffixpressed,
    this.onSubmite,
    this.isvisiable,
    this.iconColor,
    this.focusNode,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        onChanged: onChange,
        focusNode: focusNode,
        controller: controller,
        keyboardType: type,
        validator: validate,
        obscureText: isvisiable ?? false,
        onFieldSubmitted: onSubmite,
        onTap: suffixpressed,
        decoration: InputDecoration(
          suffixIcon: suffix != null && controller!.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(suffix),
                )
              : null,
          hintText: label,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
