part of 'property_cubit.dart';

@immutable
sealed class PropertyState {}

final class PropertyInitialState extends PropertyState {}

final class PropertyChangeFilterState extends PropertyState {}

final class PropertyLoadingState extends PropertyState {}

final class PropertyLoadedState extends PropertyState {}
