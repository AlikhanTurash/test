import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/models/item.dart';

class ApiService {
  final String baseUrl = 'https://api.artic.edu/api/v1';

  Future<List<Item>> fetchArtworks({int limit = 20, int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/artworks?limit=$limit&page=$page&fields=id,title,image_id,description'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> artworks = data['data'];
      return artworks.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load artworks');
    }
  }
}