import 'package:flutter/material.dart';
import 'package:user_app/data/models/onbording_model.dart';

Widget onboardingBuild(OnBoardingModle modle, context) => SingleChildScrollView(
      child: Column(
        children: [
          Text(modle.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(
            height: 10,
          ),
          Text(
            modle.paraText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Image(
            image: AssetImage(modle.image),
          ),
        ],
      ),
    );
