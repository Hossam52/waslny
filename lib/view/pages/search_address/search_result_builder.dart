import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/data/models/prediction_model.dart';
import 'package:user_app/utils/color_manager.dart';

class SearchResultBuilder extends StatelessWidget {
  const SearchResultBuilder({
    Key? key,
    required this.onPredictionPressed,
  }) : super(key: key);
  final void Function(Predictions) onPredictionPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      builder: (context, state) {
        final googleMapCubit = GoogleMapCubit.get(context);
        final predictions = googleMapCubit.predictions;
        if (state is LoadingSearchState) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (predictions != null) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: predictions.predictions!.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () async {
                    onPredictionPressed(predictions.predictions![index]);
                    // Navigator.pop(context);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_location,
                          color: ColorManager.yellow,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${predictions.predictions![index].structuredFormatting!.mainText}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${predictions.predictions![index].structuredFormatting!.secondaryText}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            },
          );
        } else {
          return const Center(
            child: Text("Detect Your Destination"),
          );
        }
      },
    );

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.fmd_good, color: Colors.grey),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
