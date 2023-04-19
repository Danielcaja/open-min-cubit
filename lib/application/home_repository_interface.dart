import '../post_model.dart';

abstract class IHomeRepository {
  Future<List<PostModel>> getItems();
  Future<bool> insertItem(PostModel model);
}
