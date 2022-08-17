import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';

import 'package:user_app/utils/color_manager.dart';

class UserProfilePic extends StatelessWidget {
  double radiusSize;
  String? image;

  UserProfilePic({
    Key? key,
    required this.radiusSize,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        log(image.toString());
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            child: Stack(
              children: [
                image == null || image == ""
                    ? CircleAvatar(
                        backgroundColor: ColorManager.offWhite,
                        radius: radiusSize,
                        backgroundImage: AssetImage(
                          "assets/images/profile_pic.jpg",
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: ColorManager.offWhite,
                        radius: radiusSize,
                        backgroundImage: NetworkImage(image!),
                      )
                // Container(
                //         width: 70,
                //         height: 70,
                //         decoration: state is SuccessUserProfileState &&
                //                 state.profileData?.photo != null
                //             ? BoxDecoration(
                //                 image: DecorationImage(
                //                     image: NetworkImage(
                //                       state.profileData!.photo.toString(),
                //                     ),
                //                     fit: BoxFit.cover),
                //                 borderRadius: BorderRadius.circular(50))
                //             : BoxDecoration(
                //                 image: LoginCubit.get(context).imageData != null
                //                     ? DecorationImage(
                //                         fit: BoxFit.cover,
                //                         image: FileImage(
                //                           LoginCubit.get(context).imageData!,
                //                         ))
                //                     : DecorationImage(
                //                         image: AssetImage(
                //                             "assets/images/profile_pic.jpg"),
                //                         fit: BoxFit.cover),
                //                 borderRadius: BorderRadius.circular(50)),
                //       ),
              ],
            ),
          ),
        );
      },
    );
  }
}
/*
 File? imagee;

  imagePick() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.imagee = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to Pick image: e");
    }
  }

                CircleAvatar(
                backgroundColor: ColorManager.offWhite,
                child:imagee!=null?Image.file(imagee!,width: 50,height: 50,): Image.asset(
                    widget.image == null || widget.image == ""
                        ? "assets/images/profile_pic.jpg"
                        : widget.image.toString()),
                radius: widget.radiusSize,
              ),

*/
