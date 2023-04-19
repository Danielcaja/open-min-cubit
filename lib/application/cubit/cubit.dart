import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../post_model.dart';
import '../home_repository_interface.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final IHomeRepository _repository;

  HomeCubit(this._repository) : super(const LoadingPostsState()) {
    getItems();
  }

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  getItems() {
    try {
      _repository.getItems().then((posts) {
        emit(LoadedPostsState(posts));
      });
    } catch (e) {
      emit(const ErrorLoadingPostsState());
    }
  }

  insertItem() {
    final items = (state as LoadedPostsState).items;
    try {
      final model = PostModel(
        userId: 1,
        title: titleController.text,
        body: bodyController.text,
      );

      emit(const LoadingPostsState());
      _repository.insertItem(model).then((inserted) {
        _repository.getItems().then((items) {
          if (inserted) {
            emit(
                InsertingResultState(items, true, 'Post inserido com sucesso'));
            titleController.clear();
            bodyController.clear();
          } else {
            emit(InsertingResultState(items, false, 'Erro ao inserir post'));
          }
        });
      });
    } catch (e) {
      emit(InsertingResultState(items, false, 'Erro ao inserir post'));
    }
  }
}
