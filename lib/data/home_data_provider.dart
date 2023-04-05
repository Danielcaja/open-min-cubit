import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../domain/home_data_provider_interface.dart';
import '../post_model.dart';

class HomeDataProvider implements IHomeDataProvider {
  final Dio _dio;

  const HomeDataProvider(this._dio);

  @override
  Future<List<PostModel>> getItems() async {
    debugPrint('Getting');
    final result = await _dio.get<List<dynamic>>('/posts');

    debugPrint('Getted');
    return result.data!.map((e) => PostModel.fromMap(e)).toList();
  }
}
