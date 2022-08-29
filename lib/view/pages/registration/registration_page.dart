import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:user_app/cubit/register/register_cubit_cubit.dart';
import 'package:user_app/utils/assets_manager.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/methods.dart';
import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/pages/login/login_page.dart';
import 'package:user_app/view/routes/route.dart';
import 'package:user_app/view/wigdets/text_button.dart';
import 'package:user_app/view/wigdets/text_feild.dart';

import '../../wigdets/checkBox.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubitCubit.get(context);
    return BlocConsumer<RegisterCubitCubit, RegisterCubitState>(
      listener: (context, state) {
        if (state is SuccessRegisterState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("successfully sign up"),
            backgroundColor: Colors.green,
          ));
          // Navigator.pushNamed(context, Routes.loginPage);
          navigateTo(context, LoginPage());
        }

        state is ErrorRegisterState
            ? _scaffoldKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text(
                    '${state.error}',
                  ),
                  duration: Duration(seconds: 3),
                  backgroundColor: ColorManager.red,
                ),
              )
            : null;
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    const SizedBox(
                      height: AppSize.s500,
                      child: Image(
                        image: AssetImage(AssetsManager.yellowBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.only(
                          top: AppMargin.m100,
                          left: AppMargin.m10,
                          right: AppMargin.m10),
                      child: Container(
                        // height: 100,
                        padding: const EdgeInsets.all(AppPadding.p30),
                        decoration: BoxDecoration(
                          color: ColorManager.offWhite,
                          borderRadius: BorderRadius.circular(AppSize.s10),
                        ),
                        child: Form(
                          key: registerFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ConstentManager.signUp,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                DefualtTextFeild(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  label: ConstentManager.name,
                                  prefix: Icons.person,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ('Enter your Name');
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: AppSize.s5,
                                ),
                                DefualtTextFeild(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  label: ConstentManager.phone,
                                  prefix: Icons.phone,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ('Enter your phone');
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: AppSize.s5,
                                ),
                                DefualtTextFeild(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  label: ConstentManager.email,
                                  prefix: Icons.email,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ('Enter your Email');
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: AppSize.s5,
                                ),
                                DefualtTextFeild(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  label: ConstentManager.password,
                                  prefix: Icons.password,
                                  isvisiable: true,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ('Enter your Password');
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: AppSize.s5,
                                ),
                                DefualtTextFeild(
                                  controller: confirmPassController,
                                  type: TextInputType.visiblePassword,
                                  label: ConstentManager.password,
                                  prefix: Icons.password,
                                  isvisiable: true,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ('Enter your Password');
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: AppSize.s5,
                                ),
                                const SizedBox(
                                  height: AppSize.s5,
                                ),
                                GenderCheckBox(
                                  isFemale: cubit.isFemale,
                                  isMale: cubit.isMale,
                                  onFemaleChanged: (bool? newValue) {
                                    cubit.changeFemaleGender();
                                  },
                                  onMaleChanged: (bool? newValue) {
                                    cubit.changeMaleGender();
                                  },
                                ),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                state is RegisterlodingState
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: ColorManager.yellow,
                                        ),
                                      )
                                    : DefualtTextButton(
                                        ontap: () {
                                          if (registerFormKey.currentState!
                                                  .validate() &&
                                              (cubit.isFemale == true ||
                                                  cubit.isMale == true)) {
                                            cubit.registerUser(
                                                nameController.text,
                                                emailController.text,
                                                passwordController.text,
                                                confirmPassController.text,
                                                phoneController.text,
                                                cubit.isMale == true
                                                    ? "male"
                                                    : "female");
                                          } else {
                                            Toast.show("select Your Gender",
                                                gravity: Toast.bottom,
                                                backgroundColor:
                                                    ColorManager.red);
                                          }
                                        },
                                        buttonText: ConstentManager.signUp,
                                        borderColor: ColorManager.yellow,
                                        textColor: ColorManager.offWhite,
                                        backgroundColor: ColorManager.yellow,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                // flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      ConstentManager.allreadyHaveAccount,
                    ),
                    TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, Routes.loginPage);
                          navigateTo(context, LoginPage());
                        },
                        child: Text(
                          ConstentManager.signIn,
                          style: Theme.of(context).textTheme.titleSmall,
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
