import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoApi {
  static const String _baseUrl = 'https://api.coincap.io/v2/rate';

  Future<List<dynamic>> fetchCryptoData() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load crypto data');
    }
  }
}