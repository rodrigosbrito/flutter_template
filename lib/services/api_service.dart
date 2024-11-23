import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/state_model.dart';
import '../config/config.dart';

class ApiService {
  Future<List<StateModel>> fetchStates() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/states'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((state) => StateModel.fromJson(state)).toList();
    } else {
      throw Exception('Failed to load states');
    }
  }
}