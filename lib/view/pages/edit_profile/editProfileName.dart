import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/utils/value_manager.dart';

import '../../../utils/color_manager.dart';

class EditProfileName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is SuccessUserProfileState) {
          Navigator.pop(context);
          cubit.textNameEdittingController.clear();
        }
      },
      builder: (context, state) {
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
            title: Text("Edit Profile Name"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
                ),
                TextFormField(
                    controller: cubit.textNameEdittingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                      hintText: "enter name",
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (cubit.textNameEdittingController == null ||
                          cubit.textNameEdittingController == "") {
                        Toast.show("You must change Data");
                      } else {
                        debugPrint(
                            "sssssssssss${cubit.textNameEdittingController.text}");
                        cubit.editUser(
                            name: cubit.textNameEdittingController.text);
                      }
                    },
                    child: State is EditNamelodingState
                        ? CircularProgressIndicator()
                        : Text("Save"),
                    style: ElevatedButton.styleFrom(
                        primary: ColorManager.yellow,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, AppSize.s50)),
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
