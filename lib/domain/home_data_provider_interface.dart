import '../post_model.dart';

abstract class IHomeDataProvider {
  Future<List<PostModel>> getItems();
  Future<void> insertItem(PostModel model);
}
