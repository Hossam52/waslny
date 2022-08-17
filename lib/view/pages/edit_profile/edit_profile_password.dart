import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/utils/value_manager.dart';

import '../../../utils/color_manager.dart';

class EditProfilePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.yellow,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Edit Profile Password"),
        ),
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextContainer(
                    suffixIcon: IconButton(
                        icon: cubit.obs1
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                                size: 20,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.black,
                                size: 20,
                              ),
                        onPressed: () async {
                          await cubit.changeObs1();
                        }),
                    obs: cubit.obs1,
                    controller: cubit.textPasswordEdittingController,
                    hint: "Enter Current Passwrod"),
                TextContainer(
                    suffixIcon: IconButton(
                        icon: cubit.obs2
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                                size: 20,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.black,
                                size: 20,
                              ),
                        onPressed: () {
                          cubit.changeObs2();
                        }),
                    obs: cubit.obs2,
                    controller: cubit.textNewPasswordEdittingController,
                    hint: "Enter New Passwrod"),
                TextContainer(
                    suffixIcon: IconButton(
                        icon: cubit.obs3
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                                size: 20,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.black,
                                size: 20,
                              ),
                        onPressed: () {
                          cubit.changeObs3();
                        }),
                    obs: cubit.obs3,
                    controller: cubit.textConfirmedPasswordEdittingController,
                    hint: "Enter confirmed Passwrod"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("${cubit.textPasswordEdittingController}");
                      debugPrint("${cubit.textNewPasswordEdittingController}");
                      debugPrint(
                          "${cubit.textConfirmedPasswordEdittingController}");

                      cubit.editPassword(
                          currentPassword:
                              cubit.textPasswordEdittingController.text,
                          newPassword:
                              cubit.textNewPasswordEdittingController.text,
                          confirmPassword: cubit
                              .textConfirmedPasswordEdittingController.text);
                    },
                    child: State is EditPasslodingState
                        ? const CircularProgressIndicator()
                        : const Text("Save"),
                    style: ElevatedButton.styleFrom(
                        primary: ColorManager.yellow,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width, AppSize.s50)),
                  ),
                )
              ],
            );
          },
        ));
  }
}

class TextContainer extends StatefulWidget {
  String hint;
  TextEditingController controller;
  Widget suffixIcon;
  bool obs;

  TextContainer({
    required this.obs,
    required this.controller,
    required this.hint,
    required this.suffixIcon,
  });

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextFormField(
                obscureText: widget.obs,
                controller: widget.controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5.0),
                  suffixIcon: widget.suffixIcon,
                  hintText: widget.hint,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
