import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10),
    Product(name: 'Product 2', price: 20),
    Product(name: 'Product 3', price: 30),
    Product(name: 'Product 4', price: 40),
    Product(name: 'Product 5', price: 50),
    Product(name: 'Product 6', price: 60),
    Product(name: 'Product 7', price: 70),
    Product(name: 'Product 8', price: 80),
    Product(name: 'Product 9', price: 90),
    Product(name: 'Product 10', price: 100),
    Product(name: 'Product 11', price: 110),
    Product(name: 'Product 12', price: 120),
    Product(name: 'Product 13', price: 130),
    Product(name: 'Product 14', price: 140),
    Product(name: 'Product 15', price: 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(products[index].name),
                  subtitle: Text('\$${products[index].price}'),
                  trailing: BuyButton(
                    product: products[index],
                    onBuy: (product) {
                      setState(() {
                        product.incrementCounter();
                        if (product.counter == 5) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Congratulations!'),
                                content: Text('You\'ve bought 5 ${product.name}!'),
                                actions: [
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
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(products: products)),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class BuyButton extends StatelessWidget {
  final Product product;
  final Function(Product) onBuy;

  BuyButton({required this.product, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Counter: ${product.counter}'),
          ElevatedButton(
            onPressed: () {
              onBuy(product);
            },
            child: Text("Buy Now"),
          ),
        ],
      ),
    );
  }
}

class Product {
  String name;
  double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});

  void incrementCounter() {
    counter++;
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  int getTotalProducts() {
    int total = 0;
    for (var product in products) {
      total += product.counter;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products: ${getTotalProducts()}'),
      ),
    );
  }
}
