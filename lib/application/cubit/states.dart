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

class InsertingResultState extends LoadedPostsState {
  final String message;
  final bool successed;

  InsertingResultState(List<PostModel> items, this.successed, this.message)
      : super(items);
}
