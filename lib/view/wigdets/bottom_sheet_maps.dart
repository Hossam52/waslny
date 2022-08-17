import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/app_cubit/app_cubit.dart';

class BottomSheetMaps extends StatelessWidget {
  const BottomSheetMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Map Type"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.changeMapHybrid();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.red,
                      ),
                    ),
                    const Text("hybrid"),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.changeMapNoraml();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.red,
                      ),
                    ),
                    const Text("noraml"),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.changeMapsatellite();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.red,
                      ),
                    ),
                    const Text("satellite"),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
