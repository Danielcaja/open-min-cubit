import '../application/home_repository_interface.dart';
import '../post_model.dart';
import 'home_data_provider_interface.dart';

class HomeRepository implements IHomeRepository {
  final IHomeDataProvider _dataProvider;

  const HomeRepository(this._dataProvider);

  @override
  Future<List<PostModel>> getItems() => _dataProvider.getItems();

  @override
  Future<bool> insertItem(PostModel model) async {
    try {
      await _dataProvider.insertItem(model);

      return true;
    } catch (e) {
      return false;
    }
  }
}
