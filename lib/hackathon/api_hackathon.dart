import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchData() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.12:8000/hackathons'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    return data;
  } else {
    throw Exception('Failed to fetch data');
  }
}
