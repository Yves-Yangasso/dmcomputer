import 'package:carousel_slider/carousel_slider.dart';
import 'package:dmcomputer/screens/panier_screen.dart';
import 'package:flutter/material.dart';
import 'carousel_screen.dart';
import 'connexion_screen.dart';
import 'drawer_screen.dart';
import 'recherche_sceeen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  bool isFavorite;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    this.isFavorite = false,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;
  List<dynamic> categories = [];
  List<Product> products = [];
  int selectedCategoryId = 0;
  bool isLoading = true; // État de chargement

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchProducts({int categoryId = 0}) async {
    String url = 'https://dmcomputer.sn/wp-json/wc/v3/products';
    if (categoryId > 0) {
      url += '?category=$categoryId';
    }

    setState(() {
      isLoading = true; // Démarrer le chargement
    });

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode("ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35"))}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> productsData = json.decode(response.body);
        setState(() {
          products = productsData.map((product) {
            return Product(
              imageUrl: product['images'][0]['src'],
              name: product['name'],
              price: double.parse(product['price']),
              description: product['description'],
            );
          }).toList();
          isLoading = false; // Terminer le chargement
        });
      } else {
        throw Exception('Échec du chargement des produits');
      }
    } catch (e) {
      print("Erreur lors de la récupération des produits: $e");
      showErrorDialog(context, "Échec du chargement des produits. Veuillez réessayer plus tard.");
      setState(() {
        isLoading = false; // Terminer le chargement même en cas d'erreur
      });
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://dmcomputer.sn/wp-json/wc/v3/products/categories'),
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode("ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35"))}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> categoriesData = json.decode(response.body);
        setState(() {
          categories = categoriesData;
        });
        if (categories.isNotEmpty) {
          fetchProducts(categoryId: categories[0]['id']);
        }
      } else {
        throw Exception('Échec du chargement des catégories');
      }
    } catch (e) {
      print("Erreur lors de la récupération des catégories: $e");
      showErrorDialog(context, "Échec du chargement des catégories. Veuillez réessayer plus tard.");
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erreur"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        _showProductDetails(context, product);
      },
      child: Card(
        elevation: 10,
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.green,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        product.isFavorite = !product.isFavorite;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                Text('${product.price} FCFA', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(product.imageUrl, height: 100, fit: BoxFit.cover), // Image du produit
              SizedBox(height: 10),
              Text(product.description),
              SizedBox(height: 10),
              Text('Prix: ${product.price} FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le popup
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageList = [
      Image.asset('images/p1.jpg', width: 300, height: 100),
      Image.asset('images/p2.jpg', width: 300, height: 100),
      Image.asset('images/p3.jpg', width: 300, height: 100),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('DMComputer.sn', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PanierScreen()));
            },
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          )
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerScreen(),
      body: ClipRect(
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              SimpleCarousel(items: imageList),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text("Catégories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text('Voir tout', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map<Widget>((category) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedCategoryId = category['id'];
                          });
                          fetchProducts(categoryId: selectedCategoryId);
                        },
                        child: Text(category['name']),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator()) // Indicateur de chargement
                    : GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  children: products.map((product) => _buildProductCard(product)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (_selectedIndex) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuScreen()));
              break;
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RechercheSceeen()));
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PanierScreen()));
              break;
            case 3:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConnexionScreen()));
              break;
          }
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}