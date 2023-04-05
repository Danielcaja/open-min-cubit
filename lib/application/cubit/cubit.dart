import 'package:bloc/bloc.dart';

import '../home_repository_interface.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final IHomeRepository _repository;

  HomeCubit(this._repository) : super(const LoadingPostsState()) {
    getItems();
  }

  getItems() {
    try {
      _repository.getItems().then((posts) {
        emit(LoadedPostsState(posts!));
      });
    } catch (e) {
      emit(const ErrorLoadingPostsState());
    }
  }
}
