import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_service.dart';
import 'package:pro_2/Data/broker_Info_model.dart';
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
  
  void getBrokerProperty(BuildContext context,int userId)async{
    emit(PropertyLoadingState());
    var response = await PropertyService.getPropertyAdsByBroker(userId);
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
  
  void getBrokerInfo(BuildContext context,int userId)async{
    emit(PropertyLoadingState());
    var response=await PropertyService.getBrokerInfo(userId);
    if(response is BrokerInfoModel){
       emit(BrokerInfoLoadedState(info: response));
    }else{
      emit(PropertyErrorState(error: response.toString()));
    }
  }

  void reportOnBroker(BuildContext context, int userid, int brokerid)async{
     await PropertyService.reportBroker(userid,brokerid).then((value){
      if(value == "Report created successfully"){
        mySnackBar(
            context: context,
            title: 'reported Successfully'
        );
      }else{
        emit(PropertyErrorState(error: value.toString()));
      }
    });
  }
  
  void rateOnBroker(BuildContext context, int userid, int brokerid,double rate)async{
     await PropertyService.rateBroker( userid, brokerid, rate).then((onValue){
      if(onValue!.message == "Evaluation added successfully"){

        CacheHelper.putInt(key: 'rateId', value: onValue.evaluation.id);
        
        mySnackBar(
            context: context,
            title: 'rated Successfully'
        );
      }else{
        emit(PropertyErrorState(error: 'Failed to rate'));
      }
    });
  }
   Future updateRateOnBroker(BuildContext context, int userid, int brokerid,double rate)async{
     await PropertyService.updateRateBroker( userid, brokerid, rate,(CacheHelper.getInt(key: 'rateId'))!).then((onValue){
      if(onValue!.message == "Evaluation updated successfully"){
        mySnackBar(
            context: context,
            title: 'rate updated Successfully'
        );
      }else{
        emit(PropertyErrorState(error: 'Failed to update rate'));
      }
    });
  }
  Future deleteRateOnBroker(BuildContext context)async{
     await PropertyService.deleteRateBroker((CacheHelper.getInt(key: 'rateId'))!).then((onValue){
      if(onValue == "Evaluation deleted successfully"){
        CacheHelper.deleteInt(key: 'rateId');
        mySnackBar(
            context: context,
            title: 'rate deleted Successfully'
        );
      }else{
        emit(PropertyErrorState(error: 'Failed to update rate'));
      }
    });
  }

}


