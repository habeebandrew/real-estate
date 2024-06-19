import 'package:bloc/bloc.dart';


part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitialState());


  void pressed(){
    emit(PostsLoadedState());
    print("iam in property");
  }
}
