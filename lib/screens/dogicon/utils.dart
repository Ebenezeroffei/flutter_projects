import 'dart:convert';
import 'package:http/http.dart' as http;

class Utils {
  Utils();

  Future<List>? getSubBreeds(String breed) async {
    // print(breed);
    Uri url = Uri.parse('https://dog.ceo/api/breed/$breed/images');
    var res = await http.get(url);
    var data = await jsonDecode(res.body);
    // print(data);
    return data['message'];
  }
}
