import 'dart:convert';

import 'package:ecom/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _loading = false;

  List<Product> get products => _products;
  bool get loading => _loading;

  Future<void> fetchProducts(
      {int? limit,
      int? skip,
      String? category,
      String? searchQuery,
      List<String>? tags}) async {
    _loading = true;
    notifyListeners();

    // Build the query parameters dynamically
    String baseUrl = 'https://dummyjson.com/products';

    // Check if category is provided
    if (category != null && category.isNotEmpty) {
      baseUrl = '$baseUrl/category/$category';
    } else if (searchQuery != null && searchQuery.isNotEmpty) {
      baseUrl = '$baseUrl/search?q=$searchQuery';
    }

    // Add limit and skip to the URL
    Map<String, dynamic> queryParams = {};
    if (limit != null) queryParams['limit'] = limit.toString();
    if (skip != null) queryParams['skip'] = skip.toString();

    if (tags != null && tags.isNotEmpty) {
      queryParams['tags'] = tags.join(',');
    }
    String queryString = Uri(queryParameters: queryParams).query;
    String finalUrl =
        queryString.isNotEmpty ? '$baseUrl?$queryString' : baseUrl;

    final response = await http.get(Uri.parse(finalUrl));

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

  Future<List<Product>> fetchProductList({
    int? limit,
    int? skip,
    String? category,
    String? searchQuery,
    List<String>? tags,
  }) async {
    String finalUrl = _buildUrl(
      limit: limit,
      skip: skip,
      category: category,
      searchQuery: searchQuery,
      tags: tags,
    );

    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonData = jsonResponse['products'];
      return jsonData.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<List<String>> fetchAllCategories() async {
    String finalUrl = 'https://dummyjson.com/products/category-list';

    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // Assuming the categories are returned in a field named 'categories'
      List<dynamic> jsonData = jsonResponse['categories']; // Change 'products' to 'categories'
      return jsonData.map((category) => category.toString()).toList(); // Convert to List<String>
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Helper function to build URL
  String _buildUrl({
    int? limit,
    int? skip,
    String? category,
    String? searchQuery,
    List<String>? tags,
  }) {
    print(tags);
    String baseUrl = 'https://dummyjson.com/products';

    // Check if category is provided
    if (category != null && category.isNotEmpty) {
      baseUrl = '$baseUrl/category/$category';
    } else if (searchQuery != null && searchQuery.isNotEmpty) {
      baseUrl = '$baseUrl/search?q=$searchQuery';
    }

    // Add limit and skip to the URL
    Map<String, dynamic> queryParams = {};
    if (limit != null) queryParams['limit'] = limit.toString();
    if (skip != null) queryParams['skip'] = skip.toString();

    if (tags != null && tags.isNotEmpty) {
      queryParams['tags'] = tags;
      // .join(',');
    }

    String queryString = Uri(queryParameters: {
      'tags': ["footwear", "sports cleats"]
    }).query;
    return queryString.isNotEmpty ? '$baseUrl?$queryString' : baseUrl;
  }
}
