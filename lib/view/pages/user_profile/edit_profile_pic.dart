import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/view/pages/user_profile/user_profile_pic.dart';

import '../../../cubit/login_cubit/login_cubit.dart';

class EditProfilePic extends StatefulWidget {
  double radiusSize;
  String? image;

  EditProfilePic({
    Key? key,
    required this.radiusSize,
    this.image,
  }) : super(key: key);

  @override
  State<EditProfilePic> createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  File? imagee;

  imagePick({ImageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.imagee = imageTemporary);
      LoginCubit.get(context).changeImageData(imageFile: imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to Pick image: e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ChangeImageUpdateState) {
          LoginCubit.get(context).UploadImage();
        }
      },
      listenWhen: (old, newState) => newState is ChangeImageUpdateState,
      buildWhen: (old, newState) => newState is ChangeImageUpdateState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text("camera"),
                            onTap: () => Navigator.of(context).pop(
                                imagePick(ImageSource: ImageSource.camera)),
                          ),
                          ListTile(
                            leading: Icon(Icons.image),
                            title: Text("Gallery"),
                            onTap: () => Navigator.of(context).pop(
                                imagePick(ImageSource: ImageSource.gallery)),
                          )
                        ],
                      ),
                    )),
            child: Stack(
              children: [
                UserProfilePic(
                  radiusSize: 30,
                  image: widget.image,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: Container(
                //     width: 80,
                //     height: 80,
                //     decoration: state is SuccessUserProfileState &&
                //             state.profileData?.photo != null
                //         ? BoxDecoration(
                //             image: DecorationImage(
                //                 image: NetworkImage(
                //                   state.profileData!.photo.toString(),
                //                 ),
                //                 fit: BoxFit.cover),
                //             borderRadius: BorderRadius.circular(50))
                //         : BoxDecoration(
                //             image: LoginCubit.get(context).imageData != null
                //                 ? DecorationImage(
                //                     fit: BoxFit.cover,
                //                     image: FileImage(
                //                       LoginCubit.get(context).imageData!,
                //                     ))
                //                 : DecorationImage(
                //                     image: AssetImage(
                //                         "assets/images/profile_pic.jpg"),
                //                     fit: BoxFit.cover),
                //             borderRadius: BorderRadius.circular(50)),
                //   ),
                // ),
                PositionedDirectional(
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 10,
                    child: Icon(
                      Icons.edit,
                      color: ColorManager.offWhite,
                      size: 12,
                    ),
                    backgroundColor: Colors.black,
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
