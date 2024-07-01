part of 'property_cubit.dart';

@immutable
sealed class PropertyState {}

final class PropertyInitialState extends PropertyState {}

final class PropertyChangeFilterState extends PropertyState {}

final class PropertyLoadingState extends PropertyState {}

final class PropertyLoadedState extends PropertyState {
  final List<Property> propertyModel;
  PropertyLoadedState({required this.propertyModel});
}

final class PropertyDetailsLoadedState extends PropertyState {
  final PropertyDetails propertyDetailsModel;
  PropertyDetailsLoadedState({required this.propertyDetailsModel});
}

final class PropertyErrorState extends PropertyState {
  final String error;
  PropertyErrorState({required this.error});
}

final class FavouriteLoadingState extends PropertyState {
}

final class FavouriteLoadedState extends PropertyState {
  final List<Favourite> favouriteModel;
  FavouriteLoadedState({required this.favouriteModel});
}

