import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_app/cubit/app_cubit/app_cubit.dart';
import 'package:user_app/data/models/onbording_model.dart';

import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/methods.dart';
import 'package:user_app/view/pages/login/login_page.dart';
import 'package:user_app/view/routes/route.dart';
import 'package:user_app/view/wigdets/text_button.dart';

import 'onbording_builder.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({Key? key}) : super(key: key);

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  late var bordingContrller = PageController();
  bool isLast = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);

        return Scaffold(
          backgroundColor: ColorManager.offWhite,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: bordingContrller,
                      onPageChanged: (index) {
                        if (index == onboardingContents.length - 1) {
                          setState(() {
                            currentIndex = index;
                            isLast = true;
                          });
                        } else {
                          isLast = false;
                        }
                      },
                      itemCount: onboardingContents.length,
                      itemBuilder: (context, index) =>
                          onboardingBuild(onboardingContents[index], context),
                    ),
                  ),
                  currentIndex != onboardingContents.length - 1
                      ? Column(
                          children: [
                            DefualtTextButton(
                              ontap: () {
                                // cubit.getLocation();
                                // Navigator.pushNamed(context, Routes.loginPage);
                                navigateTo(context, LoginPage());
                              },
                              buttonText: ConstentManager.skipToApp,
                              borderColor: ColorManager.yellow,
                              textColor: ColorManager.offWhite,
                              backgroundColor: ColorManager.yellow,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            DefualtTextButton(
                              ontap: () {
                                // Navigator.pushNamed(context, Routes.loginPage);
                                navigateTo(context, LoginPage());
                              },
                              buttonText: ConstentManager.useMyLocation,
                              borderColor: ColorManager.yellow,
                              textColor: ColorManager.offWhite,
                              backgroundColor: ColorManager.yellow,
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  SmoothPageIndicator(
                    controller: bordingContrller,
                    effect: ScrollingDotsEffect(
                      dotColor: ColorManager.gray,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      spacing: 5.0,
                      activeDotColor: ColorManager.yellow,
                    ),
                    count: onboardingContents.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
