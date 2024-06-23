part of 'posts_cubit.dart';

abstract class PostsState {}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {}

class PostsErrorState extends PostsState {
  final String message;
  PostsErrorState({required this.message});
}
