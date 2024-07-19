import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_task_by_inforce/models/cat.dart';

class CatRepository {
  Future<List<Cat>> fetchCats() async {
    final response = await http.get(Uri.parse('https://freetestapi.com/api/v1/cats'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((catJson) => Cat.fromJson(catJson)).toList()..sort((a, b) => a.name.compareTo(b.name));
    } else {
      throw Exception('Failed to load cats');
    }
  }
}