import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_service.dart';
import 'package:pro_2/Data/favourite_model.dart';
import 'package:pro_2/Data/property_details_model.dart';
import 'package:pro_2/Data/property_model.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';


part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitialState());

  static PropertyCubit get(context)=>BlocProvider.of(context);

  TextEditingController searchController =TextEditingController();

  int sliding=0;
  String dropDownStatus='all';
  String dropDownItemCites='all Cities';
  void toggleSelectedFilter(int value,BuildContext context){
    emit(PropertyChangeFilterState());
    sliding = value;
    filterSelection(context);
  }

  void filterSelection(BuildContext context){
    int? propertyTypeId;
    int? statusId;
    int? cityId;

    switch (sliding) {
      case 1:
        propertyTypeId = 1;
        break;
      case 2:
        propertyTypeId = 2;
        break;
      case 3:
        propertyTypeId = 3;
        break;
      case 4:
        propertyTypeId = 4;
        break;
      case 5:
        propertyTypeId = 5;
        break;
      case 6:
        propertyTypeId = 6;
        break;
      case 7:
        propertyTypeId = 7;
        break;
      case 8:
        propertyTypeId = 8;
        break;
      default:
        propertyTypeId = null;
    }

    if (dropDownStatus == 'sale') {
      statusId = 1;
    } else if (dropDownStatus == 'rent') {
      statusId = 2;
    } else {
      statusId = null;
    }

    if (dropDownItemCites == 'Damascus') {
      cityId = 1;
    } else if (dropDownItemCites == 'Rif-Damascus') {
      cityId = 2;
    } else if (dropDownItemCites == 'Homs') {
      cityId = 3;
    } else {
      cityId = null;
    }

    filterProperty(context, statusId: statusId, propertyTypeId: propertyTypeId, cityId: cityId,userId: CacheHelper.getInt(key: 'id'));
  }

  void getProperty(BuildContext context,int userId)async{
    emit(PropertyLoadingState());
    var response = await PropertyService.getProperty(userId);
    if (response is List<Property>){
      emit(PropertyLoadedState(propertyModel: response));
    }else{
      emit(PropertyErrorState(error: response.toString()));
    }
  }
  void filterProperty(BuildContext context,{int? statusId,int? propertyTypeId,int? cityId,int? userId})async{
    emit(PropertyLoadingState());
    var response = await PropertyService.filterProperty(statusId: statusId,propertyTypeId: propertyTypeId,cityId:cityId,userId: userId);
    if (response is List<Property>){
      emit(PropertyLoadedState(propertyModel: response));
    }else{
      emit(PropertyErrorState(error: response.toString()));
    }
  }

  void getPropertyDetails(int propertyId)async{

    emit(PropertyLoadingState());
    var response = await PropertyService.getPropertyDetails(propertyId);
    if (response is PropertyDetails){
      emit(PropertyDetailsLoadedState(propertyDetailsModel: response));
    }else{
      emit(PropertyErrorState(error: response.toString()));
    }
  }

  void addMyFavourite(BuildContext context,int id)async{
     await PropertyService.addFavourite(id).then((value){
      if(value == 'تمت إضافة العقار إلى المفضلة بنجاح'){
        mySnackBar(
            context: context,
            title: 'Added Successfully'
        );
      }else{
        emit(PropertyErrorState(error: value.toString()));
      }
    });

  }

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

  void deleteMyFavourite(BuildContext context,int propertyId)async
  {
      await PropertyService.deleteFavourite(propertyId).then((value){
        if (value == 'تم حذف العقار من المفضلة بنجاح') {
          if(state is FavouriteLoadedState) {
            final updatedFavourites = (state as FavouriteLoadedState)
                .favouriteModel
                .where((item) => item.id != propertyId)
                .toList();
            emit(FavouriteLoadedState(favouriteModel: updatedFavourites));
            mySnackBar(context: context, title: 'Deleted Successfully');
          }
          if(state is PropertyLoadedState){
            mySnackBar(context: context, title: 'Deleted Successfully');
          }
        } else {
          emit(PropertyErrorState(error: value.toString()));
        }

      });

    }


}


