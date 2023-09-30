import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharohar/data/model/user_model.dart';

class GetUserInfo {
  late UserModel user;

  Future<void> getUserInfoFromFirestore(String userId) async {
    final firestoreInstance = FirebaseFirestore.instance;
    try {
      QuerySnapshot userSnapshot = await firestoreInstance
          .collection('Users') // Replace with your collection name
          .where('uid',
              isEqualTo: userId) // Replace with the field used for email
          .get();

      print(userSnapshot.docs.isNotEmpty);
      if (userSnapshot.docs.isNotEmpty) {
        // User with the given email found
        // Access the data using userSnapshot.docs[0].data()
        Map<String, dynamic> userData =
            userSnapshot.docs[0].data() as Map<String, dynamic>;

        // Now, you can access user data, e.g., userData['name'], userData['age'], etc.
        user.fullName = userData['name'];
        user.phoneNumber = userData['phoneNumber'];
        user.email = userData['email'];
        user.address = userData['address'];
        user.city = userData['city'];
        user.state = userData['state'];
        user.pinCode = userData['pinCode'];
      } else {
        // No user found with the given email
        print(userId);
        print('sjn User not found.');
      }
    } catch (e) {
      // Handle any errors that may occur during the retrieval process
      print('Error fetching user data: $e');
    }
  }

  UserModel getUserInfo(String userId, String userEmail) {
    user = UserModel(sId: userId, email: userEmail);
    getUserInfoFromFirestore(userId);
    return user;
  }
}
