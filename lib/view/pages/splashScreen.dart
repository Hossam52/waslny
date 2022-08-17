import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/view/pages/home/home_page.dart';
import 'package:user_app/view/pages/onbording/onbording_page.dart';

import '../../data/services/localDataLayer.dart';
import '../../utils/color_manager.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() async {
    final token = await Shared.prefGetString(key: "token");
    token==null?Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => OnbordingPage())):Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.yellow,
    );
  }
}