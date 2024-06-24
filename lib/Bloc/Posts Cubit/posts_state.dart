part of 'posts_cubit.dart';

abstract class PostsState {}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostSuccess extends PostsState {
  final String message;

  PostSuccess(this.message);
}
class PostFailed extends PostsState {
  final int statusCode;
  final String error;

  PostFailed(this.statusCode, this.error);
}