import 'package:flutter/material.dart';

class DefualtTextFeild extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final String? Function(String?)? validate;
  final String? label;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? suffixpressed;
  final Function(String?)? onSubmite;
  final bool? isvisiable;
  const DefualtTextFeild({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 40.0,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: validate,
        obscureText: isvisiable ?? false,
        onFieldSubmitted: onSubmite,
        onTap: suffixpressed,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: Icon(
            suffix,
          ),
          hintText: label,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            // color: lightSky,
          ),
        ),
      ),
    );
  }
}
