part of 'property_cubit.dart';

@immutable
sealed class PropertyState {}

final class PropertyInitialState extends PropertyState {}

final class PropertyChangeFilterState extends PropertyState {}

final class PropertyLoadingState extends PropertyState {}

final class PropertyLoadedState extends PropertyState {}

final class PropertyErrorState extends PropertyState {
  final String error;
  PropertyErrorState({required this.error});
}

final class FavouriteLoadingState extends PropertyState {}

final class FavouriteLoadedState extends PropertyState {
  final List<Favourite> favouriteModel;
  FavouriteLoadedState({required this.favouriteModel});
}
final class FavouriteDeletedState extends PropertyState {}
