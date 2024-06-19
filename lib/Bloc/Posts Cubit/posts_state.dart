part of 'posts_cubit.dart';


sealed class PostsState {}

final class PostsInitialState extends PostsState {}

final class PostsLoadedState extends PostsState {}
