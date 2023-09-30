import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharohar/data/model/user_model.dart';

Future<void> addUserInfo(UserModel user) async {
  try {
    await FirebaseFirestore.instance
        .collection("Users") // Document we are adding to
        .doc(user.sId) // searching our Collection
        .set({
      'uid': user.sId,
      'name': user.fullName,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'profileProgress': 1,
      'building': user.address,
      'city': user.city,
      'state': user.state,
      'pincode': user.pinCode,
      'role': "buyer",
      'updatedOn': DateTime.now(),
      'createdOn': DateTime.now(),
    });
    print('User data added to Firestore successfully');
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}
