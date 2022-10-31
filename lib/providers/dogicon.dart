import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DogiconProvider with ChangeNotifier {
  bool _loading = true;
  List<String> _favourites = [];
  List _breeds = [];
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  bool get loading => _loading;

  List get breeds => _breeds;

  List get favourites => _favourites;

  Future<void> allBreeds() async {
    _breeds = breeds;
    Uri url = Uri.parse("https://dog.ceo/api/breeds/list/all");
    var res = await http.get(url);
    Map data = await jsonDecode(res.body)['message'];
    for (String i in data.keys.toList()) {
      _breeds.add({
        'name': i,
        'favourite': false,
      });
    }
    _loading = false;
    notifyListeners();
  }

  void toggleFavouriteBreed(bool isFav, int breedIndex) {
    _breeds[breedIndex]['favourite'] = isFav ? false : true;
    notifyListeners();
  }
}
