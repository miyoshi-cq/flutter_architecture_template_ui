import 'package:flutter_architecture_template_ui/data/identifiable.dart';

class ListUsecase<T extends Identifiable> {
  int lastId = 0;
  List<T> items = [];

  Future<List<T>> get(
    Future<List<T>> Function(int) repo,
    bool isAddtional,
  ) async {
    if (!isAddtional) {
      lastId = 0;
    }

    final response = await repo(lastId);

    if (response.isNotEmpty) {
      lastId = response.last.id;
    }

    if (isAddtional) {
      items += response;
    } else {
      items = response;
    }

    return items;
  }
}
