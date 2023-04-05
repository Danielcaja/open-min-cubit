import '../../post_model.dart';

abstract class HomeStates {
  const HomeStates();
}

class LoadingPostsState extends HomeStates {
  const LoadingPostsState();
}

class LoadedPostsState extends HomeStates {
  final List<PostModel> items;

  const LoadedPostsState(this.items);
}

class ErrorLoadingPostsState extends HomeStates {
  const ErrorLoadingPostsState();
}

abstract class InsertingResultState extends HomeStates {
  final String message;

  const InsertingResultState(this.message);
}

class ErrorInsertingPostsState extends InsertingResultState {
  ErrorInsertingPostsState(super.message);
}

class SuccessInsertingPostsState extends InsertingResultState {
  SuccessInsertingPostsState(super.message);
}
