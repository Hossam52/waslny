import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/utils/assets_manager.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/routes/route.dart';
import 'package:user_app/view/wigdets/text_button.dart';
import 'package:user_app/view/wigdets/text_feild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    passwordController.text = '123456';
    phoneController.text = '01115425562';
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        state is SuccessLoginState
            ? Navigator.pushNamed(context, Routes.homePage)
            : null;
        state is ErrorLoginState
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
          body: Form(
            key: loginFormKey,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
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
                            top: AppMargin.m200,
                            left: AppMargin.m10,
                            right: AppMargin.m10),
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p30),
                          decoration: BoxDecoration(
                            color: ColorManager.offWhite,
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ConstentManager.login,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                const SizedBox(
                                  height: AppSize.s30,
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
                                  height: AppSize.s30,
                                ),
                                state is UserLoginlodingState
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: ColorManager.yellow,
                                        ),
                                      )
                                    : DefualtTextButton(
                                        ontap: () async {
                                          if (loginFormKey.currentState!
                                              .validate()) {
                                            await cubit.loginUser(
                                                passwordController.text,
                                                phoneController.text);
                                            // Navigator.pushNamed(context, Routes.homePage);
                                          }
                                        },
                                        buttonText: ConstentManager.next,
                                        borderColor: ColorManager.yellow,
                                        textColor: ColorManager.offWhite,
                                        backgroundColor: ColorManager.yellow,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        ConstentManager.createNewAccount,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.registrationPage);
                          },
                          child: Text(
                            ConstentManager.signUp,
                            style: Theme.of(context).textTheme.titleSmall,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
