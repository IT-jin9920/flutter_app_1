import 'package:flutter/material.dart';

import 'fack_api.dart';

// Assume that the FakeStoreApi class is defined as provided in the previous answer

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      List<String> fetchedCategories = await FakeStoreApi.getAllCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fake Store App'),
      ),
      body: categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductsPage(category: category),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CategoryProductsPage extends StatefulWidget {
  final String category;

  const CategoryProductsPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      List<Map<String, dynamic>> fetchedProducts =
      await FakeStoreApi.getProductsInCategory(widget.category);
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Products'),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['title']),
            subtitle: Text('\$${product['price']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product['image'],
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text('Price: \$${product['price']}'),
            SizedBox(height: 8),
            Text('Category: ${product['category']}'),
            SizedBox(height: 8),
            Text('Description: ${product['description']}'),
          ],
        ),
      ),
    );
  }
}
