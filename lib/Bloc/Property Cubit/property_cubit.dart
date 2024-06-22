
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitialState());

  static PropertyCubit get(context)=>BlocProvider.of(context);

  TextEditingController searchController =TextEditingController();
  int sliding=0;

  void toggleSelected(int value){
    emit(PropertyChangeFilterState());
    sliding = value;

    if(sliding==0){
      print("all");
    }

  }

}
