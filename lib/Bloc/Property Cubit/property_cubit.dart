
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_service.dart';
import 'package:pro_2/Data/favourite_model.dart';


part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitialState());

  static PropertyCubit get(context)=>BlocProvider.of(context);

  TextEditingController searchController =TextEditingController();
  int sliding=0;

  void toggleSelectedFilter(int value){
    emit(PropertyChangeFilterState());
    sliding = value;

    if(sliding==0){
      print("all");
    }
  }

  void addMyFavourite(BuildContext context)async{}

 void getMyFavourite(BuildContext context)async
 {
    emit(FavouriteLoadingState());
    var response = await PropertyService.getFavourite();
    if (response is List<Favourite>){
      emit(FavouriteLoadedState(favouriteModel: response));
    }else{
      emit(PropertyErrorState(error: response.toString()));
    }
 }

  void deleteMyFavourite(BuildContext context,int id)async{
     emit(FavouriteLoadingState());
     var response = await PropertyService.deleteFavourite(id);

     if(response == 'تم حذف العقار من المفضلة بنجاح'){
         emit(FavouriteDeletedState());

     }else{
       emit(PropertyErrorState(error: response.toString()));
     }


  }


}
