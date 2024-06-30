import 'package:flutter/material.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Favourite%20Screen/Favourite%20Widgets/favourite_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, state) {
        if (state is PropertyErrorState) {
          mySnackBar(
              title: state.error,
              context: context,
              color: Colors.red
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
              color: Constants.mainColor,
              onRefresh: () async
              {
                context.read<PropertyCubit>().getMyFavourite(context);
              },
              child: ListView(
                children: [
                  if(state is FavouriteLoadingState)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin:
                            EdgeInsets.symmetric(vertical: Dimensions.heightPercentage(context, 1)),
                            padding: const EdgeInsets.all(4.0),
                            width: double.infinity,
                            height: Dimensions.screenWidth(context)/4,
                            decoration: BoxDecoration(
                              // color: Colors.grey.shade300,
                              color: Constants.mainColor4,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Shimmer(
                              color: Constants.mainColor,
                              duration: const Duration(milliseconds: 1000),
                              child: Container(),
                            ),
                          );
                        }
                    ),

                  if(state is FavouriteLoadedState)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0.0),
                        itemCount: state.favouriteModel.length,
                        itemBuilder: (context, index) {
                          final favourite = state.favouriteModel[index];
                          return FavouriteItem(
                            id: favourite.id,
                            propertyType: favourite.propertyType,
                            status: favourite.status,
                            governorate: favourite.governorate,
                            address: favourite.address,
                            createdAt: favourite.createdAt,
                            size: favourite.size,
                            price: favourite.price,
                            images: favourite.images,
                          );
                        }
                    ),
                ],
              )
          ),
        );
      },
    );
  }
}
