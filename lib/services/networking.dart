import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  Future fetchData(apiUrl) async {
    var uri = Uri.parse(apiUrl);
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      }
    } catch (e) {
      throw 'Failed to load weather:${response.statusCode}';
    }
  }
}
