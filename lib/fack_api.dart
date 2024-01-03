
import 'dart:convert';
import 'package:http/http.dart' as http;

class FakeStoreApi {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<String>> getAllCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<String> categories = List<String>.from(json.decode(response.body));
      return categories;
    } else {
      throw Exception('Failed to fetch categories. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getSingleProduct(int productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> product = json.decode(response.body);
      return product;
    } else {
      throw Exception('Failed to fetch product. Status code: ${response.statusCode}');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(json.decode(response.body));
      return products;
    } else {
      throw Exception('Failed to fetch products. Status code: ${response.statusCode}');
    }
  }

  static Future<List<Map<String, dynamic>>> getProductsInCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/products/category/$category'));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(json.decode(response.body));
      return products;
    } else {
      throw Exception('Failed to fetch products in category. Status code: ${response.statusCode}');
    }
  }
}

void main() async {
  // Example Usage:
  try {
    // Get all categories
    List<String> categories = await FakeStoreApi.getAllCategories();
    print('All Categories: $categories');

    // Get a single product
    int productId = 1;
    Map<String, dynamic> singleProduct = await FakeStoreApi.getSingleProduct(productId);
    print('Single Product: $singleProduct');

    // Get all products
    List<Map<String, dynamic>> allProducts = await FakeStoreApi.getAllProducts();
    print('All Products: $allProducts');

    // Get products in a specific category
    String category = 'jewelery';
    List<Map<String, dynamic>> productsInCategory = await FakeStoreApi.getProductsInCategory(category);
    print('Products in Category "$category": $productsInCategory');
  } catch (e) {
    print('Error: $e');
  }
}
