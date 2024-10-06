import 'dart:convert';

import 'package:ecom/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _loading = false;

  List<Product> get products => _products;
  bool get loading => _loading;

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonData = jsonResponse['products'];
      _products = jsonData.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }

    _loading = false;
    notifyListeners();
  }
}