// lib/repository.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'model.dart';

abstract class ItemRepository {
  Future<Item> addItem({required String name, required double value});
  Future<List<Item>> getItems();
  Future<void> removeItem(String id);
}

class FirebaseItemRepository extends ItemRepository {
  static const String baseUrl = 'https://test-fa118-default-rtdb.asia-southeast1.firebasedatabase.app/items.json';

  @override
  Future<Item> addItem({required String name, required double value}) async {
    final newItemData = {'name': name, 'value': value};
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newItemData),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add item');
    }

    final newId = json.decode(response.body)['name'];
    return Item(id: newId, name: name, value: value);
  }

  @override
  Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load items');
    }

    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries.map((entry) => Item(id: entry.key, name: entry.value['name'], value: entry.value['value'])).toList();
  }

  @override
  Future<void> removeItem(String id) async {
    final response = await http.delete(Uri.parse('https://test-fa118-default-rtdb.asia-southeast1.firebasedatabase.app/items/$id.json'));
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to remove item');
    }
  }
}
