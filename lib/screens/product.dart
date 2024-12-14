import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Product model
class Product {
  final int id;
  final String imageUrl;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imageUrl: json['images'][0] ?? '', // Use the first image in the list
      name: json['title'] ?? 'No Name', // Use 'title' for the product name
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }
}

class TestPro extends StatefulWidget {
  const TestPro({super.key});

  @override
  State<TestPro> createState() => _TestProState();
}

class _TestProState extends State<TestPro> {
  Product? product; // Initially null to indicate product not yet loaded
  bool isLoading = true; // Start loading as true

  @override
  void initState() {
    super.initState();
    fetchProduct(10); // Replace 10 with the desired product ID
  }

  Future<void> fetchProduct(int productId) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/$productId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final product = Product.fromJson(data);
        setState(() {
          this.product = product;
          isLoading = false;
        });
      } else {
        throw Exception('Error loading product: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error: $error');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading product'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DMComputer.sn'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : product == null
          ? Center(child: Text('No product found'))
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(product!.imageUrl, height: 200, fit: BoxFit.cover),
              SizedBox(height: 16),
              Text(
                product!.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Price: ${product!.price} FCFA',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              // ... other product information if needed
            ],
          ),
        ),
      ),
    );
  }
}