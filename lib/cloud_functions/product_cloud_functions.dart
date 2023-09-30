import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharohar/data/model/product_model.dart';

class ProductCloudFunctions {
  Future<void> createProduct(ProductModel productModel) async {
    try {
      CollectionReference products =
          await FirebaseFirestore.instance.collection("Products");
      await products.add(productModel.toJson());
      print('User data added to Firestore successfully');
    } catch (e) {
      print('Error adding user data to Firestore: $e');
    }
  }

  Future<List<DocumentSnapshot>> fetchAllProducts() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products') // Replace with the name of your collection
          .get();

      return querySnapshot.docs;
    } catch (error) {
      print('Error fetching products: $error');
      return [];
    }
  }
}
