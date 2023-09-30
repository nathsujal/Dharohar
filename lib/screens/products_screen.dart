import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharohar/cloud_functions/product_cloud_functions.dart';
import 'package:dharohar/constants/colors.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    final products = GetProducts().then((value) => isloading = true);
    super.initState();
  }

  bool isloading = true;

  Future<List<DocumentSnapshot>> GetProducts() async {
    final obj = ProductCloudFunctions();
    final products = await obj.fetchAllProducts();
    for (final product in products) {
      print("Product: ${product.data}");
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              catergory("Millet based products"),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 225,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      product(
                        "assets/img/Millet Murukku.jpeg",
                        "Millet Murukku",
                        20.0,
                      ),
                      product(
                        "assets/img/Organic Ragi Powder.jpeg",
                        "Organic Ragi Powder",
                        30.0,
                      ),
                      product(
                        "assets/img/Thinai Ladoo _ Millet Laddu.jpeg",
                        "Thinai Ladoo | Millet Laddu",
                        50.0,
                      )
                    ],
                  ),
                ),
              ),
              catergory("Milk products"),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 225,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      product(
                        "assets/img/milk.jpeg",
                        "Milk",
                        20.0,
                      ),
                      product(
                        "assets/img/butter.jpeg",
                        "Butter",
                        30.0,
                      ),
                      product(
                        "assets/img/milk-and-cheese.jpg",
                        "Cheese",
                        50.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container catergory(String categoryName) {
    return Container(
      width: double.infinity,
      height: 22,
      color: AppColor.primaryColor.withOpacity(0.3),
      child: Text(
        categoryName,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  Container product(String image, String name, double price) {
    return Container(
      width: 150.0,
      height: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 80,
            child: Image.asset(image, fit: BoxFit.fill),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Price: Rs.$price",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
