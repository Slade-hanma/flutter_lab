// lib/providers.dart
import 'package:flutter/material.dart';
import 'repository.dart';
import 'async_value.dart';
import 'model.dart';

class ItemProvider extends ChangeNotifier {
  final ItemRepository _repository;
  AsyncValue<List<Item>>? itemsState;

  ItemProvider(this._repository) {
    fetchItems();
  }

  bool get isLoading => itemsState?.state == AsyncValueState.loading;
  bool get hasData => itemsState?.state == AsyncValueState.success;

  void fetchItems() async {
    try {
      itemsState = AsyncValue.loading();
      notifyListeners();

      itemsState = AsyncValue.success(await _repository.getItems());
    } catch (error) {
      itemsState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void addItem(String name, double value) async {
    await _repository.addItem(name: name, value: value);
    fetchItems();
  }

  void removeItem(String id) async {
    await _repository.removeItem(id);
    itemsState?.data?.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
