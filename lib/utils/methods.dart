import 'package:flutter/material.dart';

Future<dynamic> navigateTo(BuildContext context, Widget page) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
Future<dynamic> navigateToReplacement(BuildContext context, Widget page) =>
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
